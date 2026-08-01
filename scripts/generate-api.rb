#!/usr/bin/env ruby
# frozen_string_literal: true

# Render api/formula/*.json and api/cask/*.json in the Homebrew API format.
#
# Run with `brew ruby scripts/generate-api.rb` so Homebrew's Ruby API is loaded.
#
# mise fetches these over raw.githubusercontent.com. Platform-specific `url`,
# `sha256` and `depends_on` live under the top-level "variations" key, keyed by
# bottle tag, exactly as formulae.brew.sh publishes them: consumers deep-merge
# the entry matching their own tag over the base hash.

require "json"

TAP = "himkt/tap"
ROOT = Pathname(__dir__).parent

# Keys describing the state of the machine that ran this script, not the package.
FORMULA_STRIP = %w[installed linked_keg pinned outdated].freeze
CASK_STRIP = %w[installed installed_time outdated].freeze

# Homebrew derives the tap from a package's location under Library/Taps. This
# repo is that tap, but packages are read from the working tree so `make api`
# reflects uncommitted edits, so the association is restored explicitly.
def tap_git_head
  @tap_git_head ||= Dir.chdir(ROOT) { Utils.safe_popen_read("git", "rev-parse", "HEAD").chomp }
end

def stamp_tap_identity(hash, path, name_key:, full_name_key:)
  hash["tap"] = TAP
  hash[full_name_key] = "#{TAP}/#{hash.fetch(name_key)}"
  hash["ruby_source_path"] = "#{path.dirname.basename}/#{path.basename}"
  hash["tap_git_head"] = tap_git_head
  hash
end

# The tag whose hash becomes the base that "variations" is diffed against. Every
# formula is evaluated under an explicitly simulated tag rather than under the
# running machine's own platform, so macOS and Linux generate identical files.
BASE_TAG_PRIORITY = %i[arm64_sequoia sequoia arm64_linux x86_64_linux].freeze

def bottle_tag(symbol)
  OnSystem::VALID_OS_ARCH_TAGS.find { |tag| tag.to_sym == symbol } ||
    raise("#{symbol} is not a bottle tag Homebrew recognises")
end

# Evaluate a formula as the given tag sees it, or return nil when that platform
# is unsupported. Formulae here ship prebuilt binaries, so a tag whose assets the
# upstream project never published cannot be evaluated at all: the `on_macos` /
# `on_arm` blocks leave the spec without a URL and Formula.new rejects it.
def formula_hash_for_tag(name, path, contents, tag)
  Homebrew::SimulateSystem.with_tag(tag) do
    namespace = Formulary.class_s("Variations#{tag.to_sym.capitalize}")
    klass = Formulary.load_formula(name, path, contents, namespace, flags: [], ignore_errors: true)
    klass.new(name, path, :stable, alias_path: nil, force_bottle: false)
        .to_hash.except(*FORMULA_STRIP)
  end
rescue FormulaSpecificationError
  nil
end

# An unsupported platform is absent from "variations" — the same conclusion a
# consumer draws when no entry matches its own tag.
def formula_hash(path)
  name = path.stem
  contents = path.read

  by_tag = OnSystem::VALID_OS_ARCH_TAGS.filter_map do |tag|
    hash = formula_hash_for_tag(name, path, contents, tag)
    [tag.to_sym, hash] if hash
  end.to_h
  raise "#{name} publishes no artifact for any platform Homebrew supports" if by_tag.empty?

  # Any supported tag can serve as the base; the priority list only keeps the
  # choice stable for the platforms this tap actually targets.
  base_tag = BASE_TAG_PRIORITY.find { |tag| by_tag.key?(tag) } || by_tag.keys.first
  base = by_tag.fetch(base_tag)

  variations = {}
  by_tag.except(base_tag).each do |tag, hash|
    hash.each do |key, value|
      next if value.to_s == base[key].to_s

      variations[tag] ||= {}
      variations[tag][key] = value
    end
  end

  stamp_tap_identity(base.merge("variations" => variations), path,
                     name_key: "name", full_name_key: "full_name")
end

# Casks run on macOS only, so the base tag is pinned rather than picked: an Intel
# Mac and an ARM Mac then generate the same file, and Homebrew's own
# `to_hash_with_variations` fills in every other tag.
def cask_hash(path)
  hash = Homebrew::SimulateSystem.with_tag(bottle_tag(BASE_TAG_PRIORITY.first)) do
    Cask::CaskLoader.load(path).to_hash_with_variations.except(*CASK_STRIP)
  end
  stamp_tap_identity(hash, path, name_key: "token", full_name_key: "full_token")
end

def write(path, hash)
  path.dirname.mkpath
  path.write("#{JSON.pretty_generate(hash.sort.to_h)}\n")
  puts "Generated #{path.relative_path_from(ROOT)}"
end

formulae = (ROOT/"Formula").glob("*.rb").sort
casks = (ROOT/"Casks").glob("*.rb").sort
raise "No formulae or casks found under #{ROOT}" if formulae.empty? && casks.empty?

formulae.each { |path| write(ROOT/"api/formula/#{path.stem}.json", formula_hash(path)) }
casks.each { |path| write(ROOT/"api/cask/#{path.stem}.json", cask_hash(path)) }

# api/ describes what the tap currently ships, so metadata for a package that no
# longer has a source file is deleted rather than left to advertise it.
{ "api/formula" => formulae, "api/cask" => casks }.each do |dir, sources|
  stems = sources.map(&:stem)
  (ROOT/dir).glob("*.json").sort.each do |path|
    next if stems.include?(path.stem)

    path.delete
    puts "Removed #{path.relative_path_from(ROOT)}"
  end
end

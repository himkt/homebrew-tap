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

# Evaluate a formula once per bottle tag and record the keys that differ from
# the base hash. Formulae here ship prebuilt binaries, so a tag whose assets the
# upstream project never published cannot be evaluated at all: the `on_macos` /
# `on_arm` blocks leave the spec without a URL and Formula.new rejects it. Such a
# tag is genuinely unsupported and is therefore absent from "variations" — the
# same conclusion a consumer draws when no entry matches its platform.
def formula_variations(formula, base)
  path = formula.path
  contents = path.read
  variations = {}

  OnSystem::VALID_OS_ARCH_TAGS.each do |tag|
    Homebrew::SimulateSystem.with_tag(tag) do
      namespace = Formulary.class_s("Variations#{tag.to_sym.capitalize}")
      klass = Formulary.load_formula(formula.name, path, contents, namespace,
                                     flags: formula.class.build_flags, ignore_errors: true)
      variation = klass.new(formula.name, path, :stable,
                            alias_path: formula.alias_path, force_bottle: false)

      variation.to_hash.each do |key, value|
        next if FORMULA_STRIP.include?(key)
        next if value.to_s == base[key].to_s

        variations[tag.to_sym] ||= {}
        variations[tag.to_sym][key] = value
      end
    rescue FormulaSpecificationError
      next
    end
  end

  variations
end

def formula_hash(path)
  formula = Formulary.factory(path)
  hash = formula.to_hash.except(*FORMULA_STRIP)
  hash["variations"] = formula_variations(formula, hash)
  stamp_tap_identity(hash, path, name_key: "name", full_name_key: "full_name")
end

def cask_hash(path)
  cask = Cask::CaskLoader.load(path)
  hash = cask.to_hash_with_variations.except(*CASK_STRIP)
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

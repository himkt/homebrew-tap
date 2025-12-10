# Copied from homebrew-voicevox
# :link: https://github.com/VOICEVOX/homebrew-voicevox
#
# Modification: himkt
#
cask "voicevox" do
  arch arm: "arm64", intel: "x64"

  version "0.25.0"
  sha256 arm: "69e4cf9afb6d5602f821f45d09dfb95d08b56edeee5693b34ab249db18a8c902",
         intel: "4ab37ad6840bbe89e9a33c1e48c6ad1a8da351fc801ab269cbfbce0c070da049"

  url "https://github.com/VOICEVOX/voicevox/releases/download/#{version}/VOICEVOX.#{version}-#{arch}.dmg",
      verified: "github.com/VOICEVOX/voicevox/"
  name "VOICEVOX"
  desc "Free, medium-quality text-to-speech and singing synthesizer software"
  homepage "https://voicevox.hiroshiba.jp/"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "VOICEVOX.app"

  zap trash: [
    "~/Library/Application Support/voicevox",
    "~/Library/Application Support/voicevox-cpu",
    "~/Library/Application Support/voicevox-engine",
    "~/Library/Logs/voicevox-cpu",
    "~/Library/Preferences/jp.hiroshiba.voicevox.plist",
    "~/Library/Saved Application State/jp.hiroshiba.voicevox.savedState",
  ]
end


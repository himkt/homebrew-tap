cask "vigil" do
  version "1.1"
  sha256 "4baa57c580210d8d1a8a4a118a483f41c22b1b432cb248971ff0a918cebfac81"

  url "https://github.com/morishin/Vigil/releases/download/v#{version}/Vigil.zip"
  name "Vigil"
  desc "Menu bar app that prevents system sleep, even with the lid closed"
  homepage "https://github.com/morishin/Vigil"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Vigil.app"

  uninstall quit: "dev.morishin.Vigil"

  zap delete: "/etc/sudoers.d/vigil",
      trash:  "~/Library/Preferences/dev.morishin.Vigil.plist"
end

cask "notchhider" do
  version "1.2.0"
  sha256 "45df05d82a448859ddbf2563cfa88a5b9eceeda753f7b1c84deaa245bfd2772b"

  url "https://github.com/NiZZioN/NotchHider/releases/download/v#{version}/NotchHider-#{version}.zip"
  name "Notch Hider"
  desc "Hides the MacBook notch with a true-black or blurred-glass menu bar strip"
  homepage "https://github.com/NiZZioN/NotchHider"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "NotchHider.app"

  # Ad-hoc signed, not notarized: clear the download quarantine so macOS lets it open.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/NotchHider.app"]
  end

  uninstall_preflight_steps do
    run "{{appdir}}/NotchHider.app/Contents/MacOS/NotchHider",
        args:         ["--unregister-login-item"],
        must_succeed: false
  end

  uninstall quit: "dev.notchhider.NotchHider"

  zap trash: "~/Library/Preferences/dev.notchhider.NotchHider.plist"

  caveats <<~EOS
    Open Notch Hider from Applications. Its Settings window has "Launch at login".
  EOS
end

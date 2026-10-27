class Keypress < Formula
  desc "Menu bar stopwatch for input actions and pointing difficulty"
  homepage "https://github.com/kaihendry/keypress"
  url "https://github.com/kaihendry/keypress/releases/download/v0.1.0/keypress-0.1.0.tar.gz"
  sha256 "1909200f66cbb2cc2c0eef9db1495c5435e7dc5aadfa245f2aa0842091a9be04"
  license "MIT"

  depends_on :macos
  uses_from_macos "swift" => :build

  def install
    # Homebrew already sandboxes the build; macOS cannot nest sandbox-exec profiles.
    system "./scripts/build.sh", "--disable-sandbox",
           "--cache-path", buildpath/".build/cache",
           "--config-path", buildpath/".build/configuration",
           "--security-path", buildpath/".build/security"
    prefix.install "build/Keypress.app"
    (bin/"keypress").write <<~SH
      #!/bin/bash
      if [[ "$#" -gt 0 ]]; then
        exec "#{opt_prefix}/Keypress.app/Contents/MacOS/Keypress" "$@"
      fi
      exec /usr/bin/open "#{opt_prefix}/Keypress.app"
    SH
  end

  def caveats
    <<~EOS
      Run `keypress` to open the menu bar stopwatch.
      Enable Accessibility and Input Monitoring for Keypress when prompted.

      To add Keypress to Finder and Spotlight:
        mkdir -p ~/Applications
        ln -s #{opt_prefix}/Keypress.app ~/Applications/Keypress.app

      Updates do not restart the app. Choose Quit in its panel, then run `keypress`.
      Quitting clears the current session totals. `keypress --version` prints the installed build.
    EOS
  end

  test do
    assert_match "Keypress #{version} (git 43793e585eca)", shell_output("#{bin}/keypress --version")
    assert_match "Usage:", shell_output("#{bin}/keypress --help")
    system "/usr/bin/codesign", "--verify", "--deep", "--strict", prefix/"Keypress.app"
  end
end

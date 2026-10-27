class Keypress < Formula
  desc "Menu bar stopwatch for input actions and pointing difficulty"
  homepage "https://github.com/kaihendry/keypress"
  url "https://github.com/kaihendry/keypress/releases/download/v0.1.0/keypress-0.1.0.tar.gz"
  sha256 "501a8e293c360580a366db502eb943b0b8137349a4795785e32eeaedab3f01e6"
  license "MIT"

  depends_on :macos
  uses_from_macos "swift" => :build

  def install
    system "make", "build"
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
    assert_match "Keypress #{version} (git a91bca3ccfd5)", shell_output("#{bin}/keypress --version")
    assert_match "Usage:", shell_output("#{bin}/keypress --help")
    system "/usr/bin/codesign", "--verify", "--deep", "--strict", prefix/"Keypress.app"
  end
end

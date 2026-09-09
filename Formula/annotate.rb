class Annotate < Formula
  desc "Screenshot annotation with boxes, arrows, and text"
  homepage "https://github.com/kaihendry/annotate"
  url "https://github.com/kaihendry/annotate/archive/refs/tags/v1.0.tar.gz"
  sha256 "3c6e89c4c2170c10d19fb3929d15a674a917e1f8ba47addbffef4b990c207c76"
  license "MIT"

  depends_on :macos
  uses_from_macos "swift" => :build

  def install
    system "make", "app"
    prefix.install "Annotate.app"
    bin.write_exec_script prefix/"Annotate.app/Contents/MacOS/annotate"
  end

  def caveats
    <<~EOS
      Run `annotate` to start, or `annotate image.png` to open an image.

      To add Annotate to Finder and Spotlight:
        mkdir -p ~/Applications
        ln -s #{opt_prefix}/Annotate.app ~/Applications/Annotate.app
    EOS
  end

  test do
    output = testpath/"annotated.png"
    system bin/"annotate", test_fixtures("test.png"),
           "--box", "1,1,8,8", "--arrow", "1,1,8,8",
           "--text", "1,1,Homebrew", "--out", output
    assert_path_exists output
    assert_equal "89504e470d0a1a0a", output.binread(8).unpack1("H*")
  end
end

class Annotate < Formula
  desc "Screenshot annotation with boxes, arrows, and text"
  homepage "https://github.com/kaihendry/annotate"
  url "https://github.com/kaihendry/annotate/archive/refs/tags/v1.1.tar.gz"
  sha256 "7b7f906d58729c125912d7947e8e2d0eb0b46518d1b0fc23b131c162a6072acd"
  license "MIT"

  depends_on :macos
  uses_from_macos "swift" => :build

  def install
    system "make", "app"
    prefix.install "Annotate.app"
    bin.write_exec_script prefix/"Annotate.app/Contents/MacOS/annotate"
    mv bin/"annotate", bin/"annotate-screenshot" # Avoid the annotate command from gd.
  end

  def caveats
    <<~EOS
      Run `annotate-screenshot` to start, or `annotate-screenshot image.png` to open an image.

      To add Annotate to Finder and Spotlight:
        mkdir -p ~/Applications
        ln -s #{opt_prefix}/Annotate.app ~/Applications/Annotate.app
    EOS
  end

  test do
    output = testpath/"annotated.png"
    system bin/"annotate-screenshot", test_fixtures("test.png"),
           "--box", "1,1,8,8", "--arrow", "1,1,8,8",
           "--text", "1,1,Homebrew", "--out", output
    assert_path_exists output
    assert_equal "89504e470d0a1a0a", output.binread(8).unpack1("H*")
  end
end

class Unitarylab < Formula
  desc "UnitaryLab CLI — interactive quantum agent"
  homepage "https://github.com/unitarylab/unitarylab-agent"
  version "0.1.5"

  on_macos do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v0.1.5/unitarylab-macos-arm64"
      sha256 "e187739589386f65629db8be97632908da803dcb8acaaa6fcb59315737899d60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v0.1.5/unitarylab-linux-arm64"
      sha256 "2749b1f4a2b24050253493dbcbfdcf87d45d1498561834747f9221f13dec61f4"
    end
    on_intel do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v0.1.5/unitarylab-linux-x86_64"
      sha256 "1d00893943d6dcf0493d638f6d013238db6517b1f8a6fadf0960bec58d8d270f"
    end
  end

  def install
    downloaded = Dir["unitarylab-*"].first || Dir["*"].first
    bin.install downloaded => "unitarylab"
  end

  def caveats
    on_macos do
      <<~EOS
        如果首次运行被 macOS Gatekeeper 拦截，请执行：
          xattr -cr $(brew --prefix)/bin/unitarylab
      EOS
    end
  end

  test do
    assert_match "unitarylab", shell_output("#{bin}/unitarylab --help 2>&1")
  end
end
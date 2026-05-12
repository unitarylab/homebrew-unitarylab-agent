class Unitarylab < Formula
  desc "UnitaryLab CLI — interactive quantum agent"
  homepage "https://github.com/unitarylab/unitarylab-agent"
  version "0.1.5"

  on_macos do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-macos-arm64"
      sha256 "2b2246be327694aa55c42ce518704d3ad3a23d1391043e928199aa5b8c007325"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-arm64"
      sha256 "22e357f72894d08c824e11628a0b08f4660aa3d47e2d7471ad0a41ed6647a8e4"
    end
    on_intel do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-x86_64"
      sha256 "7617b060a54e9242a9658235dcfa0fbdfb039e9b6aa1b5e2b3a80aa34cb9386b"
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
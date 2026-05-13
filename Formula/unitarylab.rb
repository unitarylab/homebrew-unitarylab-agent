class Unitarylab < Formula
  desc "UnitaryLab CLI — interactive quantum agent"
  homepage "https://github.com/unitarylab/unitarylab-agent"
  version "0.1.5"

  on_macos do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-macos-arm64"
      sha256 "150ea155529ff91622a70dfb3f73d7d6aada410bb4c87fff5213b30f8348f15d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-arm64"
      sha256 "3285acfc7bd633230f7820dfebf9f33063ddde5665a594be9c2aa0573da3bd8c"
    end
    on_intel do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-x86_64"
      sha256 "855c3dbf3d72cebe1262434cd72801bbe094674fe96ac271883583604f17f2a9"
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
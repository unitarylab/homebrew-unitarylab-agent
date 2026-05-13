class Unitarylab < Formula
  desc "UnitaryLab CLI — interactive quantum agent"
  homepage "https://github.com/unitarylab/unitarylab-agent"
  version "0.1.5"

  on_macos do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-macos-arm64"
      sha256 "c78623eec25abf498d8ef60957a11400f3fafce619d3f322fee7bec5fcf949cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-arm64"
      sha256 "a37f2c009cdc3fc3a8a9da951a5de2e9fd893371d05c52361f06cd6c6b4342fa"
    end
    on_intel do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-x86_64"
      sha256 "e707e1738ad7ab78d5121e8fbefe35ddad3699807efa746fbd196c12eea109a6"
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
class Unitarylab < Formula
  desc "UnitaryLab CLI — interactive quantum agent"
  homepage "https://github.com/unitarylab/unitarylab-agent"
  version "0.1.5"

  on_macos do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-macos-arm64"
      sha256 "2a397ce7b58417dec0c462027de4a8f0f848e5b33c4d05fbdfbf53bbbfd3ecab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-arm64"
      sha256 "34787300475373a0c59cf0b7358d5978a2c22081a9ae0ceb008ee7f3c6ba1542"
    end
    on_intel do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-x86_64"
      sha256 "29c64a643af8ae480489edda4ff4a01c105bc6573f8be51eae71abd4fe09d2d8"
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
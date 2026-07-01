class Unitarylab < Formula
  desc "UnitaryLab CLI — interactive quantum agent"
  homepage "https://github.com/unitarylab/unitarylab-agent"
  version "0.1.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-macos-arm64"
      # unitarylab:update: macos-arm64
      sha256 "47a2f04ea6d7b50927c34b8f593a60872e3155b502a39b936ad0109218badff5"
    end

    on_intel do
      odie "macOS Intel binary is not available for UnitaryLab CLI v#{version}."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-arm64"
      # unitarylab:update: linux-arm64
      sha256 "4789742ad55e513d3ec62e0978856f63cf7016477bc642331b481430c9f4c5f4"
    end

    on_intel do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-x86_64"
      # unitarylab:update: linux-x86_64
      sha256 "d298284d0c24fa7ddbc9523beb4d4e5ded402135083d0c29d1900a82d4da38f1"
    end
  end

  def install
    binary = Dir["unitarylab-*"].find { |f| File.file?(f) }
    odie "Downloaded UnitaryLab binary was not found." if binary.nil?

    chmod 0755, binary
    bin.install binary => "unitarylab"
  end

  def caveats
    on_macos do
      <<~EOS
        If macOS Gatekeeper blocks UnitaryLab on first launch, run:

          xattr -cr #{bin}/unitarylab

        Verify the installation with:

          unitarylab --help
      EOS
    end
  end

  test do
    output = shell_output("#{bin}/unitarylab --help 2>&1")
    assert_match(/unitarylab|UnitaryLab|Usage|help/i, output)
  end
end

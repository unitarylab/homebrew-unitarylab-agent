class Unitarylab < Formula
  desc "UnitaryLab CLI — interactive quantum agent"
  homepage "https://github.com/unitarylab/unitarylab-agent"
  version "0.1.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-macos-arm64"
      # unitarylab:update: macos-arm64
      sha256 "4ff6415f649694986d74b11268bfbec484cc23eef0f9f82438e7ecd0a108b9cc"
    end

    on_intel do
      odie "macOS Intel binary is not available for UnitaryLab CLI v#{version}."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-arm64"
      # unitarylab:update: linux-arm64
      sha256 "3b1f30c62ff423d9cd4a6b81ed421ea6f9cc3b3e163c6a6dfee0660d74653329"
    end

    on_intel do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-x86_64"
      # unitarylab:update: linux-x86_64
      sha256 "c0864baddaa104afe4a716a27f5c0a992bda560c9db15662d941dcb4df1d191d"
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

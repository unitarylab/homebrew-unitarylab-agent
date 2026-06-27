class Unitarylab < Formula
  desc "UnitaryLab CLI — interactive quantum agent"
  homepage "https://github.com/unitarylab/unitarylab-agent"
  version "0.1.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-macos-arm64"
      # unitarylab:update: macos-arm64
      sha256 "48336f6b795e7b90faf7bbb36387a66e696a6ee7327c5913d5881b54ed90da98"
    end

    on_intel do
      odie "macOS Intel binary is not available for UnitaryLab CLI v#{version}."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-arm64"
      # unitarylab:update: linux-arm64
      sha256 "ed40122338ba03f3051085e4340ccaf57732cb3501c2d5940f131eebb3469614"
    end

    on_intel do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-x86_64"
      # unitarylab:update: linux-x86_64
      sha256 "95973af73738249d59e7883d33aa5389b8673ccbc8a9fcf7526605e3163ae336"
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

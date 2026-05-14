class Unitarylab < Formula
  desc "UnitaryLab CLI — interactive quantum agent"
  homepage "https://github.com/unitarylab/unitarylab-agent"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-macos-arm64"
      # unitarylab:update: macos-arm64
      sha256 "553a278c4d15edbfa83c9a57b694c86f9941660d3e7463818108a4feb2577e34"
    end

    on_intel do
      odie "macOS Intel binary is not available for UnitaryLab CLI v#{version}."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-arm64"
      # unitarylab:update: linux-arm64
      sha256 "e1a431077d23964dffcb93e459b4f415e6e046cebe6e9f397ac6d820836b1dc1"
    end

    on_intel do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-x86_64"
      # unitarylab:update: linux-x86_64
      sha256 "92c178892bc360e7dfafe2b18874246e22c28489c7390c14538526ed2f0b9680"
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
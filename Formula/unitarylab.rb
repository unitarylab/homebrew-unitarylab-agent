class Unitarylab < Formula
  desc "UnitaryLab CLI — interactive quantum agent"
  homepage "https://github.com/unitarylab/unitarylab-agent"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-macos-arm64"
      # unitarylab:update: macos-arm64
      sha256 "8cff0ff89691479cae13bfadf8494d776377ae44563f9986651f94d31428003c"
    end

    on_intel do
      odie "macOS Intel binary is not available for UnitaryLab CLI v#{version}."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-arm64"
      # unitarylab:update: linux-arm64
      sha256 "50348bbd5380f13f21248afa8c6b8b61a3f6d5dfd8e121c8d00ba6da8e6d7bba"
    end

    on_intel do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-x86_64"
      # unitarylab:update: linux-x86_64
      sha256 "b6ec717cf1721aaf6e77032a1d5f02d796a9895b9acc7316a43067d0a0cb2a8c"
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
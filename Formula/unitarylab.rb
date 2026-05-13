class Unitarylab < Formula
  desc "UnitaryLab CLI — interactive quantum agent"
  homepage "https://github.com/unitarylab/unitarylab-agent"
  version "0.1.5"

  on_macos do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-macos-arm64"
      sha256 "1557af5075606b3cc8bd61632e0f74e5cba4b5c29065f55b588d0dab83d8ca41"
    end

    on_intel do
      odie "macOS Intel binary is not available for UnitaryLab CLI v#{version}. Please use an Apple Silicon Mac or install manually if a macOS x86_64 binary is released later."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-arm64"
      sha256 "d0f0d7f39cbe56956a2434706593fa2a6e94a307ef1cdc628fe62aa7ce31e51f"
    end

    on_intel do
      url "https://github.com/unitarylab/unitarylab-agent/releases/download/v#{version}/unitarylab-linux-x86_64"
      sha256 "585e69fd529730e8023f6b2206b40b50a572d6964f35a824eb1bd74f3a73602b"
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

        Then verify the installation with:

          unitarylab --help
      EOS
    end
  end

  test do
    output = shell_output("#{bin}/unitarylab --help 2>&1")
    assert_match(/unitarylab|UnitaryLab|Usage|help/i, output)
  end
end
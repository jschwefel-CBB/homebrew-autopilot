class Autopilot < Formula
  desc "Declarative macOS GUI test driver via the Accessibility API"
  homepage "https://github.com/jschwefel-CBB/autopilot-macos"
  version "1.0.0"
  license "MIT"

  on_arm do
    url "https://github.com/jschwefel-CBB/autopilot-macos/releases/download/v1.0.0/autopilot-1.0.0-arm64.tar.gz"
    sha256 "7832caa6764b8eea4684b4a920641d41cbad9f6ac8bb4fdc8bf95eebbde4a636"
  end

  def install
    bin.install "autopilot"
    bin.install "AutopilotMCP"
  end

  def caveats
    <<~EOS
      AutoPilot requires Accessibility permission to drive other apps.
      Grant it to Terminal (or whichever process runs autopilot) in:
        System Settings → Privacy & Security → Accessibility

      Run `autopilot doctor` to verify permissions.
    EOS
  end

  test do
    assert_match "AutoPilot", shell_output("#{bin}/autopilot --version 2>&1", 1)
  end
end

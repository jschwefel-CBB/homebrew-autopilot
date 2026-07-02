class Autopilot < Formula
  desc "Declarative macOS GUI test driver via the Accessibility API"
  homepage "https://github.com/jschwefel-CBB/autopilot-macos"
  version "3.1.0"
  license "MIT"

  on_arm do
    url "https://github.com/jschwefel-CBB/autopilot-macos/releases/download/v3.1.0/autopilot-3.1.0-arm64.tar.gz"
    sha256 "7343809f8ccaef5191c60ad954a2545b809175656b84d9f46c30880114c56755"
  end

  def install
    bin.install "autopilot"
    bin.install "AutopilotMCP"
    # The file-drop helper (drag + toFiles) must sit next to the autopilot
    # binary — FileDragSource locates it as AutopilotDragSource.app alongside
    # the CLI. Install the whole .app bundle into bin.
    bin.install "AutopilotDragSource.app"
  end

  def caveats
    <<~EOS
      AutoPilot requires Accessibility permission to drive other apps.
      Grant it to Terminal (or whichever process runs autopilot) in:
        System Settings → Privacy & Security → Accessibility

      Real file drag-and-drop (the `drag` action's `toFiles`) also needs a real
      display — it cannot run headless — and uses the bundled
      AutopilotDragSource.app helper installed alongside `autopilot`.

      Run `autopilot doctor` to verify permissions.
    EOS
  end

  test do
    assert_match "AutoPilot", shell_output("#{bin}/autopilot --version 2>&1", 1)
  end
end

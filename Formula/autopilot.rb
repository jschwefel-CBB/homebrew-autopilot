class Autopilot < Formula
  desc "Declarative macOS GUI test driver via the Accessibility API"
  homepage "https://github.com/jschwefel-CBB/autopilot-macos"
  version "3.1.2"
  license "MIT"

  on_arm do
    url "https://github.com/jschwefel-CBB/autopilot-macos/releases/download/v3.1.2/autopilot-3.1.2-arm64.tar.gz"
    sha256 "d13f0d72109a39d0d7ff144dfa2bdcecfa202e2d6f9214f3f45dd8479f2eb36e"
  end

  def install
    bin.install "autopilot"
    bin.install "AutopilotMCP"
    # The file-drop helper (drag + toFiles) must sit next to the autopilot
    # binary — FileDragSource locates it as AutopilotDragSource.app alongside
    # the CLI. Install the whole .app bundle into bin.
    bin.install "AutopilotDragSource.app"
    # Ship the user-facing docs into share/doc/autopilot so `autopilot docs`
    # finds them (it looks for share/doc/autopilot next to the binary) and
    # `brew --prefix autopilot` / `brew home` expose them.
    doc.install Dir["docs/*"]
    # The cockpit GUI app — installed next to the CLI, consistent with the drag
    # helper. Launch with `open "#{HOMEBREW_PREFIX}/bin/AutopilotCockpit.app"`.
    bin.install "AutopilotCockpit.app"
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

      Documentation is installed with the formula:
        autopilot docs            # list the bundled docs
        autopilot docs manual     # print the full user manual
        autopilot docs authoring  # how to write a test plan
      or browse them at #{HOMEBREW_PREFIX}/share/doc/autopilot.

      The AutoPilot Cockpit GUI (Inspect / Author / Run) is installed too:
        open #{HOMEBREW_PREFIX}/bin/AutopilotCockpit.app
      Grant it Accessibility permission on first launch to drive other apps.
    EOS
  end

  test do
    assert_match "AutoPilot", shell_output("#{bin}/autopilot --version 2>&1", 1)
  end
end

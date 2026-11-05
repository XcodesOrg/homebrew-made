class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "2.1.0"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url "https://github.com/XcodesOrg/xcodes/releases/download/2.1.0"
    # The release ships one universal (arm64 + x86_64) binary. The `all` tag
    # matches every macOS version and architecture; `mojave` tags are no
    # longer recognised by Homebrew and are never selected.
    sha256 cellar: :any_skip_relocation, all: "ac254cc1fca16743302709d3d97419b434681930613c16b9748d6af7687f2430"
  end

  resource "XcodesLoginKit" do
    url "https://github.com/XcodesOrg/XcodesLoginKit.git",
        revision: "929f9aac3140caf7b64cbb5385f4f645c5f9913d"
  end

  resource "XcodesKit" do
    url "https://github.com/XcodesOrg/XcodesKit.git",
        revision: "f88cce3de084538e30ec40168b5aa36181e7eed9"
  end

  def install
    resource("XcodesLoginKit").stage buildpath/"XcodesLoginKit"
    resource("XcodesKit").stage buildpath/"XcodesKit"

    package_swift = buildpath/"Package.swift"
    package_swift.atomic_write package_swift.read
      .gsub('.package(path: "../XcodesLoginKit")', '.package(path: "XcodesLoginKit")')
      .gsub('.package(path: "../XcodesKit")', '.package(path: "XcodesKit")')
      .gsub('.package(url: "https://github.com/XcodesOrg/XcodesLoginKit.git", branch: "main")',
            '.package(path: "XcodesLoginKit")')
      .gsub('.package(url: "https://github.com/XcodesOrg/XcodesKit.git", .upToNextMinor(from: "1.1.0"))',
            '.package(path: "XcodesKit")')

    # Build for the native architecture only. The Makefile's universal
    # (arm64 + x86_64) build fails to link the x86_64 slice with the macOS 27
    # Command Line Tools, and its hard-coded output path no longer matches
    # current Swift toolchains. A native build is what homebrew-core does too.
    system "swift", "build", *std_swift_args, "--disable-sandbox"
    bin.install ".build/release/xcodes"
  end

  test do
    system "#{bin}/xcodes"
  end
end

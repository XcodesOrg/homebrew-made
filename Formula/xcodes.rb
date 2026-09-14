class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "2.1.0"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url "https://github.com/XcodesOrg/xcodes/releases/download/2.0.3"
    sha256 cellar: :any_skip_relocation, arm64_mojave: "ac254cc1fca16743302709d3d97419b434681930613c16b9748d6af7687f2430"
    sha256 cellar: :any_skip_relocation, mojave:       "ac254cc1fca16743302709d3d97419b434681930613c16b9748d6af7687f2430"
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

    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/xcodes"
  end
end

class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "2.2.0"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url "https://github.com/XcodesOrg/xcodes/releases/download/2.2.0"
    sha256 cellar: :any_skip_relocation, arm64_mojave: "fbef98d38afd142629460074bcf279af0df4eb242364737d0ecf888f513856d0"
    sha256 cellar: :any_skip_relocation, mojave:       "fbef98d38afd142629460074bcf279af0df4eb242364737d0ecf888f513856d0"
  end
  
  depends_on macos: :ventura
  depends_on xcode: ["16.0", :build]

  resource "XcodesLoginKit" do
    url "https://github.com/XcodesOrg/XcodesLoginKit.git",
        revision: "929f9aac3140caf7b64cbb5385f4f645c5f9913d"
  end

  resource "XcodesKit" do
    url "https://github.com/XcodesOrg/XcodesKit.git",
        revision: "37617957ae33310455bfe7cf0835d69e0a6aa3c5"
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
      .gsub('.package(url: "https://github.com/XcodesOrg/XcodesKit.git", .upToNextMinor(from: "1.2.0"))',
            '.package(path: "XcodesKit")')

    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/xcodes"
  end
end

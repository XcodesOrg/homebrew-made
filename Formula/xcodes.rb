class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "2.2.1"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url "https://github.com/XcodesOrg/xcodes/releases/download/2.2.1"
    sha256 cellar: :any_skip_relocation, all: "4a932fd93359bccc9585f67d7b1b98a57135c2a82d3f0fa7ff2c3fc356574232"
  end
  
  depends_on macos: :ventura
  depends_on xcode: ["16.0", :build]

  resource "XcodesLoginKit" do
    url "https://github.com/XcodesOrg/XcodesLoginKit.git",
        revision: "2ef7f39462ab29b56211e35a01ad85ae6cca00a2"
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
      .gsub('.package(url: "https://github.com/XcodesOrg/XcodesLoginKit.git", revision: "v1.2.0")',
            '.package(path: "XcodesLoginKit")')
      .gsub('.package(url: "https://github.com/XcodesOrg/XcodesKit.git", .upToNextMinor(from: "1.2.0"))',
            '.package(path: "XcodesKit")')

    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/xcodes"
  end
end

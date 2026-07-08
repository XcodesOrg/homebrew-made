class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "2.0.3"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url "https://github.com/XcodesOrg/xcodes/releases/download/2.0.3"
    sha256 cellar: :any_skip_relocation, arm64_mojave: "d0251244b8a02b5af1eb5fa5618c6efff6e387d51f749b631b9c7cceee476fae"
    sha256 cellar: :any_skip_relocation, mojave:       "d0251244b8a02b5af1eb5fa5618c6efff6e387d51f749b631b9c7cceee476fae"
  end

  resource "XcodesLoginKit" do
    url "https://github.com/XcodesOrg/XcodesLoginKit.git",
        revision: "9bece1ada36006b18b84caec62d14dc91b47ae2b"
  end

  resource "XcodesKit" do
    url "https://github.com/XcodesOrg/XcodesKit.git",
        revision: "a9e5d7d701f20f1385071851319cdaecccc9f1e8"
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
      .gsub('.package(url: "https://github.com/XcodesOrg/XcodesKit.git", .upToNextMinor(from: "1.0.4"))',
            '.package(path: "XcodesKit")')

    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/xcodes"
  end
end

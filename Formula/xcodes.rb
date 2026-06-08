class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "2.0.1"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url "https://github.com/XcodesOrg/xcodes/releases/download/2.0.1"
    sha256 cellar: :any_skip_relocation, arm64_mojave: "e7d0ebec0bd15f519b6ac0a07cf500afbac3386ed9c6baa84cfbef73a32d36ac"
    sha256 cellar: :any_skip_relocation, mojave:       "e7d0ebec0bd15f519b6ac0a07cf500afbac3386ed9c6baa84cfbef73a32d36ac"
  end

  resource "XcodesLoginKit" do
    url "https://github.com/XcodesOrg/XcodesLoginKit.git",
        revision: "9bece1ada36006b18b84caec62d14dc91b47ae2b"
  end

  resource "XcodesKit" do
    url "https://github.com/XcodesOrg/XcodesKit.git",
        revision: "5bff14052f7664f75a4837547804e07c3c2dfe47"
  end

  def install
    resource("XcodesLoginKit").stage buildpath/"XcodesLoginKit"
    resource("XcodesKit").stage buildpath/"XcodesKit"

    inreplace "Package.swift" do |s|
      s.gsub! '.package(path: "../XcodesLoginKit")', '.package(path: "XcodesLoginKit")'
      s.gsub! '.package(path: "../XcodesKit")', '.package(path: "XcodesKit")'
    end

    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/xcodes"
  end
end

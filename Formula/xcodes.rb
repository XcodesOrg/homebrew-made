class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "2.0.1"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url 'https://github.com/XcodesOrg/xcodes/releases/download/2.0.1'
    sha256 cellar: :any_skip_relocation, mojave: "e7d0ebec0bd15f519b6ac0a07cf500afbac3386ed9c6baa84cfbef73a32d36ac"
    sha256 cellar: :any_skip_relocation, arm64_mojave: "e7d0ebec0bd15f519b6ac0a07cf500afbac3386ed9c6baa84cfbef73a32d36ac"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/xcodes"
  end
end

class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "1.6.2"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url 'https://github.com/XcodesOrg/xcodes/releases/download/1.6.2'
    sha256 cellar: :any_skip_relocation, mojave: "c4530102af12850d63fd674bdcf6030649be47e1f7d283450b6f526c9285c4f7"
    sha256 cellar: :any_skip_relocation, arm64_mojave: "c4530102af12850d63fd674bdcf6030649be47e1f7d283450b6f526c9285c4f7"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/xcodes"
  end
end

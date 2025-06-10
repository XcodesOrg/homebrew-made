class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "1.6.1"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url 'https://github.com/XcodesOrg/xcodes/releases/download/1.6.1'
    sha256 cellar: :any_skip_relocation, mojave: "9f206a012c5d0a45abdd45ec28476c8d503622276bb276b6d23f2aacf3686643"
    sha256 cellar: :any_skip_relocation, arm64_mojave: "9f206a012c5d0a45abdd45ec28476c8d503622276bb276b6d23f2aacf3686643"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/xcodes"
  end
end

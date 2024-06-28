class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "1.5.0"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url 'https://github.com/XcodesOrg/xcodes/releases/download/1.5.0'
    sha256 cellar: :any_skip_relocation, mojave: "348f58b7ba7e7a0ad4c63cfd3609560a228cbe371def20740b1e44c8c41684cd"
    sha256 cellar: :any_skip_relocation, arm64_mojave: "348f58b7ba7e7a0ad4c63cfd3609560a228cbe371def20740b1e44c8c41684cd"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/xcodes"
  end
end

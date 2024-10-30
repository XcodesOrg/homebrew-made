class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "1.6.0"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url 'https://github.com/XcodesOrg/xcodes/releases/download/1.6.0'
    sha256 cellar: :any_skip_relocation, mojave: "02cee050f9ea0fd33f96dd4c8c7fbcf406d520de6c5db6977967f59cfbfadb5d"
    sha256 cellar: :any_skip_relocation, arm64_mojave: "02cee050f9ea0fd33f96dd4c8c7fbcf406d520de6c5db6977967f59cfbfadb5d"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/xcodes"
  end
end

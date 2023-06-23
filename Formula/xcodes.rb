class Xcodes < Formula
  desc "Install and switch between multiple versions of Xcode"
  homepage "https://www.xcodes.app"
  url "https://github.com/XcodesOrg/xcodes.git", tag: "1.4.1"
  head "https://github.com/XcodesOrg/xcodes.git", branch: "main"

  bottle do
    root_url 'https://github.com/XcodesOrg/xcodes/releases/download/1.4.1'
    sha256 cellar: :any_skip_relocation, mojave: "f9c66503f1a2d5d9d7f48ea053a2739b35dd0f7325e668ff4c1062539416b409"
    sha256 cellar: :any_skip_relocation, arm64_mojave: "f9c66503f1a2d5d9d7f48ea053a2739b35dd0f7325e668ff4c1062539416b409"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/xcodes"
  end
end

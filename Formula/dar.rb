class Dar < Formula
  desc "Backup directory tree and files"
  homepage "http://dar.linux.free.fr/doc/index.html"
  url "https://downloads.sourceforge.net/project/dar/dar/2.7.1/dar-2.7.1.tar.gz"
  sha256 "76dade8adbeb817ffc78bf592c8200487ab5650234cf539539a9cbc5d346beef"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/dar[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any, big_sur:  "6f163404147ed366f1b61505d13959967527ea224f98463b6e2e87ea4d7bd426"
    sha256 cellar: :any, catalina: "f0c2475f1398a76f313bc3b0e002b1f2d42153dbb3b7d250da0eaa0f06686335"
    sha256 cellar: :any, mojave:   "17e45df3068bc2d41e87c555fb2fcbbb6decff97f586f801cfe0cfdffa1cee61"
  end

  depends_on "upx" => :build
  depends_on "libgcrypt"
  depends_on "lzo"

  def install
    # Need to set due to upstream issue: https://github.com/Edrusb/DAR/issues/29
    ENV.append "CXXFLAGS", "-std=c++14"

    system "./configure", "--prefix=#{prefix}",
                          "--disable-build-html",
                          "--disable-dar-static",
                          "--disable-dependency-tracking",
                          "--disable-libxz-linking",
                          "--enable-mode=64"
    system "make", "install"
  end

  test do
    system bin/"dar", "-c", "test", "-R", "./Library"
    system bin/"dar", "-d", "test", "-R", "./Library"
  end
end

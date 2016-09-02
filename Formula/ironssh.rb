class Ironssh < Formula
  desc "Fork of OpenSSH adding transparent E2E encryption to file transfers"
  homepage "https://ironcorelabs.com/products/ironsftp"
  url "https://github.com/IronCoreLabs/ironssh/archive/0.9.1.tar.gz"
  sha256 "6b2f78244dd836afdf6da561fda73d16fe42477b7f4034b1aeb09d75f23aff47"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "openssl"
  depends_on "libsodium"

  def install
    system "autoreconf"

    system "./configure",
                          "--with-ssl-dir=#{Formula["openssl"].opt_prefix}",
                          "--with-libedit=/usr",
                          "--prefix=#{prefix}"

    system "make", "SSH_PROGRAM=/usr/bin/ssh", "ironsftp"
    system "make", "install"
  end

  test do
    assert_match /usage: ironsftp/, shell_output("ironsftp 2>&1", 1)
  end
end

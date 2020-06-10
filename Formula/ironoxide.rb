class Ironssh < Formula
  desc "Ironoxide C bindings and headers"
  homepage "https://ironcorelabs.com/"
  url "https://github.com/IronCoreLabs/ironoxide-java/releases/download/v0.13.1/libironoxide_java-centos7.tar.gz"
  sha256 "6b2f78244dd836afdf6da561fda73d16fe42477b7f4034b1aeb09d75f23aff47"

  depends_on "pkg-config" => :build

  def install
    include.install "headers" => "ironoxide"
    lib.install "libironoxide.a"
    cp "ironoxide.pc.in", "ironoxide.pc"
    inreplace "ironoxide.pc", "%PREFIX%", prefix
    (lib/"pkgconfig").install "ironoxide.pc"
  end


  test do
    (testpath/"libironoxide.c").write <<~EOS
      #include <stdlib.h>
      #include <stdio.h>
      #include <c_UserId.h>
      int main()
      {
          return 0;
      }
    EOS
    system ENV.cc, "libironoxide.c", "-L#{lib}", "-I#{include}", "-o", "libironoxidetest"
    assert_equal "", shell_output("./libironoxidetest")
  end
end

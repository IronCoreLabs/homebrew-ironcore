class Ironoxide < Formula
  desc "Ironoxide C bindings and headers"
  homepage "https://ironcorelabs.com/"
  url "https://github.com/IronCoreLabs/ironoxide-swig-bindings/releases/download/v0.14.7/ironoxide-homebrew.tar.gz"
  sha256 "76c12fb29c6b0954e72e5b99222c4401d4675fed0505f35563afcb9e897e1a55"

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

class Vlink < Formula
  desc "Portable linker for multiple file formats"
  homepage "http://sun.hasenbraten.de/vlink/"
  url "http://sun.hasenbraten.de/vlink/release/vlink.tar.gz"
  version "0.18a"
  sha256 "8d151cdd30a4feb575a364e68810c2bc300fe1a7c074dbbee6fd1175a6c5bfae"
  license ""

  def install
    system "make", "vlink"
    bin.install "vlink"
  end

  test do
    system bin/"vlink", "-h"
  end
end

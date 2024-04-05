class Picorng < Formula
  desc "Command line utility for the PICoRNG USB random number generator"
  homepage "https://shop.sudomaker.com/products/picorng-random-number-generator"
  license "AGPLv3"
  head "https://github.com/SudoMaker/PICoRNG.git"
  url "https://github.com/SudoMaker/PICoRNG.git",
    revision: "1a6794360f2c0e117e4979e937f953a629770ab4"
  version "0.0.1"

  depends_on "cmake" => :build
  depends_on 'pkg-config' => :build
  depends_on 'libusb'
  
  def install
    mkdir "Software/PICoRNG_Utility/build" do
      system "cmake", ".."
      system "make"
      bin.install "PICoRNG"
    end
  end

  test do
    system "PICoRNG", "--help"
  end
end

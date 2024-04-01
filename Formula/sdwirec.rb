class Sdwirec < Formula
  desc "Command-line contoller for the sd-mux (Secure Digital Multiplexer) device"
  homepage "https://badgerd.nl/sdwirec/"
  url "https://github.com/Badger-Embedded/badgerd-sdwirec.git",
    revision: "0ede9c272550ecff5675a2e1af7cb6566bca048e"
  version "1.3"
  license "Apache-2.0"
  head "https://github.com/Badger-Embedded/badgerd-sdwirec.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libftdi"
  depends_on "popt"

  def install
    mkdir "sdwirec-sw/build" do
      system "cmake", ".."
      system "make"
      bin.install "src/sd-mux-ctrl"
    end
    bash_completion.install "sdwirec-sw/etc/bash_completion.d/sd-mux-ctrl" => "sdwirec"
  end

  test do
    system "sd-mux-ctrl", "--help"
  end
end

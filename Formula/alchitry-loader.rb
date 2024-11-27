class AlchitryLoader < Formula
  desc "Command-line loader program for the Au and Cu"
  homepage "https://alchitry.com/pages/alchitry-loader"
  url "https://github.com/ianmclinden/alchitry-loader.git",
    revision: "41591a642d1a8479f415dc9ccfd6a2c71a733c5d"
  version "1.0.0"
  license "MIT"
  head "https://github.com/ianmclinden/alchitry-loader.git", branch: "main"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", ".."
      system "make"
      bin.install "alchitry_loader"
    end
  end

  test do
    system "#{bin}/alchitry_loader", "-h"
  end
end

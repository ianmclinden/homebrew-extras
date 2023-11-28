class AlchitryLoader < Formula
  desc "Command-line loader program for the Au and Cu"
  homepage "https://alchitry.com/pages/alchitry-loader"
  url "https://github.com/ianmclinden/alchitry-loader.git",
    tag: "4263e3925b611626e503ae452e430ad42680157e"
  version "1.0.0"
  license "MIT"
  head "https://github.com/ianmclinden/alchitry-loader.git", branch: "main"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", ".."
      system "make"
      bin.install "alchitry-loader"
    end
  end

  test do
    system "#{bin}/alchitry-loader", "-h"
  end
end

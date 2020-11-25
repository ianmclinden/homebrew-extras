class AlchitryLoader < Formula
  desc "Command line loader program for the Au and Cu"
  homepage "https://alchitry.com/pages/alchitry-loader"
  license "MIT"
  head "https://github.com/ianmclinden/alchitry-loader.git"
  url "https://github.com/ianmclinden/alchitry-loader.git",
    revision: "220c2edbfefd44074a28f3d539752569e7396352"
  version "1.0.0"

  def install
    system "make"
    bin.install "build/alchitry-loader"
  end

  test do
    system "alchitry-loader", "--version"
  end
end

class FomuToolchain < Formula
  desc "A collection of tools for developing for Fomu"
  homepage "https://github.com/im-tomu/fomu-toolchain"
  head "https://github.com/im-tomu/fomu-toolchain.git"
  url "https://github.com/im-tomu/fomu-toolchain/releases/download/v1.6/fomu-toolchain-macOS.zip"
  sha256 "fffee66b044aed4862252239413fc7250d092d205fb20bda78b671c3e09f691e"
  license "MIT"

  option "with-python", "Install python3 from fomu-toolchain"
  option "with-make", "Install make toolchain from fomu-toolchain"

  def install
    if not build.with? "python"
      # TODO
    end
    if not build.with? "make"
      # TODO
    end
    prefix.install "include", "lib", "riscv64-unknown-elf", "bin", "libexec", "share"
  end

  test do
    system "yosys", "--version"
    system "nextpnr-ice40", "--version"
    system "dfu-util", "--version"
    system "riscv64-unknown-elf-gcc", "--version"
    system "wishbone-tool", "--version"
  end
end

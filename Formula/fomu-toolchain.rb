class FomuToolchain < Formula
  desc "A collection of tools for developing for Fomu"
  homepage "https://github.com/im-tomu/fomu-toolchain"
  head "https://github.com/im-tomu/fomu-toolchain.git"
  url "https://github.com/im-tomu/fomu-toolchain/releases/download/v1.5.6/fomu-toolchain-macos-v1.5.6.zip"
  sha256 "17f543c4140063a7a6eb2e7712d5b42c10206f30f542b29343aad314fccac491"
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
    prefix.install "include", "lib", "riscv64-unknown-elf", "bin", "info", "libexec", "share"
  end

  test do
    system "yosys", "--version"
    system "nextpnr-ice40", "--version"
    system "dfu-util", "--version"
    system "riscv64-unknown-elf-gcc", "--version"
    system "wishbone-tool", "--version"
  end
end

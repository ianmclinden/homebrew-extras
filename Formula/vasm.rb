class Vasm < Formula
  desc "Portable and retargetable assembler"
  homepage "http://sun.hasenbraten.de/vasm/index.php"
  url "http://phoenix.owl.de/tags/vasm1_9f.tar.gz"
  version "1.9f"
  sha256 "a09d4ff3b5ec50bb7538fb97b9539141376580b590586463569783c36438ebe8"
  license ""

  option "without-6502", "Don't install the 6502 CPU module"
  option "without-6800", "Don't install the 6800 CPU module"
  option "without-6809", "Don't install the 6809 CPU module"
  option "without-arm", "Don't install the arm CPU module"
  option "without-c16x", "Don't install the c16x CPU module"
  option "without-jagrisc", "Don't install the jagrisc CPU module"
  option "without-m68k", "Don't install the m68k CPU module"
  option "without-pdp11", "Don't install the pdp11 CPU module"
  option "without-ppc", "Don't install the ppc CPU module"
  option "without-qnice", "Don't install the qnice CPU module"
  option "without-test", "Don't install the test CPU module"
  option "without-tr3200", "Don't install the tr3200 CPU module"
  option "without-vidcore", "Don't install the vidcore CPU module"
  option "without-x86", "Don't install the x86 CPU module"
  option "without-z80", "Don't install the z80 CPU module"

  option "without-std-syntax", "Don't install the std syntax module"
  option "without-madmac-syntax", "Don't install the madmac syntax module"
  option "without-mot-syntax", "Don't install the mot syntax module"
  option "without-oldstyle-syntax", "Don't install the oldstyle syntax module"
  option "with-test-syntax", "Install test syntax module"

  option "without-vobjdump", "Don't install the vasm vobjdump tool"

  def compile_arch(cpu, syntax)
    if build.with? "#{syntax}-syntax"
      system "make", "CPU=#{cpu}", "SYNTAX=#{syntax}", "vasm#{cpu}_#{syntax}"
    end
  end

  def install_cpu(cpu)
    if build.with? cpu
      compile_arch cpu, "std"
      compile_arch cpu, "madmac"
      compile_arch cpu, "mot"
      compile_arch cpu, "oldstyle"
      compile_arch cpu, "test"
      bin.install Dir["vasm#{cpu}_*"]
    end
  end

  def install
    # ---- CPU-specific binaries ----
    install_cpu "6502"
    install_cpu "6800"
    install_cpu "6809"
    install_cpu "arm"
    install_cpu "c16x"
    install_cpu "jagrisc"
    install_cpu "m68k"
    install_cpu "pdp11"
    install_cpu "ppc"
    install_cpu "qnice"
    install_cpu "test"
    install_cpu "tr3200"
    install_cpu "vidcore"
    install_cpu "x86"
    install_cpu "z80"

    # ---- Vobjdump binary ----
    if build.with? "vobjdump"
      system "make", "vobjdump"
      bin.install "vobjdump"
    end
  end

  def test_arch(cpu, syntax)
    if build.with? "#{syntax}-syntax"
      (testpath/"test.s").write "\tnop"
      system "#{bin}/vasm#{cpu}_#{syntax}", "test.s", "-Fbin", "-o", "test.bin"
    end
  end

  def test_cpu(cpu)
    if build.with? cpu
      test_arch cpu, "std"
      test_arch cpu, "madmac"
      test_arch cpu, "mot"
      test_arch cpu, "oldstyle"
      test_arch cpu, "test"
    end
  end

  test do
    test_cpu "6502"
    test_cpu "6800"
    test_cpu "6809"
    test_cpu "arm"
    test_cpu "c16x"
    test_cpu "jagrisc"
    test_cpu "m68k"
    test_cpu "pdp11"
    test_cpu "ppc"
    test_cpu "qnice"
    test_cpu "test"
    test_cpu "tr3200"
    test_cpu "vidcore"
    test_cpu "x86"
    test_cpu "z80"
  end
end

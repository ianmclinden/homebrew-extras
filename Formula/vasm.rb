class Vasm < Formula
  desc "Portable and retargetable assembler"
  homepage "http://sun.hasenbraten.de/vasm/index.php"
  url "http://phoenix.owl.de/tags/vasm2_0.tar.gz"
  sha256 "210334b0326d54dfd21fe6c065ceca990a6b5da762d59c6c0f9d8c3e5f6a6093"
  license ""

  option "without-6502", "Don't install the 6502 CPU module"
  option "without-6800", "Don't install the 6800 CPU module"
  option "without-6809", "Don't install the 6809 CPU module"
  option "without-arm", "Don't install the ARM CPU module"
  option "without-c16x", "Don't install the C16x/ST10 CPU module"
  option "without-hans", "Don't install the HANS CPU module"
  option "without-jagrisc", "Don't install the Jaguar RISC CPU module"
  option "without-m68k", "Don't install the M680x0 CPU module"
  option "without-pdp11", "Don't install the PDP-11 CPU module"
  option "without-ppc", "Don't install the PowerPC CPU module"
  option "without-qnice", "Don't install the QNICE CPU module"
  option "with-test", "Install the test CPU module"
  option "without-tr3200", "Don't install the TR3200 CPU module"
  option "without-vidcore", "Don't install the Raspberry Pi VideoCore CPU module"
  option "without-x86", "Don't install the 80x86 CPU module"
  option "without-z80", "Don't install the Z80 CPU module"

  option "without-std-syntax", "Don't install the Standard (GNU-as) syntax module"
  option "without-madmac-syntax", "Don't install the Atari MadMac syntax module"
  option "without-mot-syntax", "Don't install the Motorolla/Freescale 68k syntax module"
  option "without-oldstyle-syntax", "Don't install the Old 8-bit syntax module"
  option "with-test-syntax", "Install test syntax module"

  option "without-vobjdump", "Don't install the vasm vobjdump tool"

  def install_cpu(cpu)
    if build.with? cpu
      syntaxes = %w[std madmac mot oldstyle test]
      syntaxes.each do |syntax|
        if build.with? "#{syntax}-syntax"
          system "make", "CPU=#{cpu}", "SYNTAX=#{syntax}", "vasm#{cpu}_#{syntax}"
          bin.install Dir["vasm#{cpu}_#{syntax}"]
        end
      end
    end
  end

  def install
    # ---- CPU-specific binaries ----
    cpus = %w[6502 6800 6809 arm c16x hans jagrisc m68k pdp11 ppc qnice test tr3200 vidcore x86 z80]
    cpus.each do |cpu|
      install_cpu cpu
    end

    # ---- Vobjdump binary ----
    if build.with? "vobjdump"
      system "make", "vobjdump"
      bin.install "vobjdump"
    end
  end

  def test_cpu(cpu)
    if build.with? cpu
      syntaxes = %w[std madmac mot oldstyle test]
      syntaxes.each do |syntax|
        if build.with? "#{syntax}-syntax"
          (testpath/"test.s").write "\tnop"
          system "#{bin}/vasm#{cpu}_#{syntax}", "test.s", "-Fbin", "-o", "test.bin"
        end
      end
    end
  end

  test do
    cpus = %w[6502 6800 6809 arm c16x hans jagrisc m68k pdp11 ppc qnice test tr3200 vidcore x86 z80]
    cpus.each do |cpu|
      test_cpu cpu
    end
  end
end

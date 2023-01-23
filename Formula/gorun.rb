class Gorun < Formula
  desc "Run Go programs as scripts with a shebang"
  homepage "https://github.com/erning/gorun"
  head "https://github.com/erning/gorun.git"
  license "GPL-3"

  depends_on "go" => :build    

  def install
    system "go", "build", "-o", bin/"gorun"
  end

  test do
    (testpath/test.go).write_exec_script <<~EOS
      #!/usr/bin/env gorun

      package main

      func main() {
        println("Hello world!")
      }
    EOS
    system testpath/"test.go"
  end
end

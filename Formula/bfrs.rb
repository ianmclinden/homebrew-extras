class Bfrs < Formula
  desc "Brainfuck interpreter, written in Rust"
  homepage "https://github.com/ianmclinden/bfrs"
  url "https://github.com/ianmclinden/bfrs.git",
    tag:      "v0.1.0",
    revision: "4c8ebf2e60bebd8a33ec54c05abd93c74d910930"
  license "MIT"
  head "https://github.com/ianmclinden/brfs.git", branch: "main"

  depends_on "rust" => :build

  def install
    # prevent unnecessarily re-downloading rust toolchain
    ENV["CARGO_HOME"] = "#{HOMEBREW_CACHE}/cargo_cache"
    ENV.prepend_path "PATH", "#{HOMEBREW_CACHE}/cargo_cache/bin"
    ENV["PREFIX"] = "#{HOMEBREW_PREFIX}"

    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/brfs", "--help"
  end
end

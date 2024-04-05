class PicorngRs < Formula
  desc "Command-line utility for the PICoRNG USB random number generator"
  homepage "https://shop.sudomaker.com/products/picorng-random-number-generator"
  url "https://github.com/ianmclinden/picorng-rs.git",
    revision: "8efd7f4636c71d0e68f003d3dde532a51557c7f8"
  version "0.1.0"
  license "AGPL-3.0-or-later"
  head "https://github.com/ianmclinden/picorng-rs.git",
    branch: "main"

  depends_on "rust" => :build

  conflicts_with "picorng", because: "picorng also ships a PICoRNG binary"

  def install
    # prevent unnecessarily re-downloading rust toolchain
    ENV["CARGO_HOME"] = "#{HOMEBREW_CACHE}/cargo_cache"
    ENV.prepend_path "PATH", "#{HOMEBREW_CACHE}/cargo_cache/bin"
    ENV["PREFIX"] = HOMEBREW_PREFIX.to_s

    system "cargo", "install", *std_cargo_args
  end

  test do
    system "PICoRNG", "--help"
  end
end

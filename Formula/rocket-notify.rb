class RocketNotify < Formula
  desc "Simple command-line client to send messages to Rocket.Chat"
  homepage "https://github.com/ianmclinden/rocket-notify"
  url "https://github.com/ianmclinden/rocket-notify.git",
    tag:      "1.2.0",
    revision: "5d6f3e57d84122749ff10df3bdb30d04cfa98fa9"
  license "MIT"
  head "https://github.com/ianmclinden/rocket-notify.git", branch: "main"

  depends_on "rust" => :build

  def install
    # prevent unnecessarily re-downloading rust toolchain
    ENV["CARGO_HOME"] = "#{HOMEBREW_CACHE}/cargo_cache"
    ENV.prepend_path "PATH", "#{HOMEBREW_CACHE}/cargo_cache/bin"
    ENV["PREFIX"] = "#{HOMEBREW_PREFIX}"

    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/rocket-notify", "--version"
  end
end

class RocketNotify < Formula
  desc "Simple command-line client to send messages to Rocket.Chat"
  homepage "https://github.com/ianmclinden/rocket-notify"
  url "https://github.com/ianmclinden/rocket-notify.git",
    tag:      "v1.1.0",
    revision: "fe643869a8b18f146119de238e210c3a0d07b010"
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

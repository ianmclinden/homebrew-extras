class UpdateMotd < Formula
  desc "Dynamic MOTD generation"
  homepage "https://github.com/ianmclinden/motd-rs"
  head "https://github.com/ianmclinden/motd-rs.git", branch:"main"
  url "https://github.com/ianmclinden/motd-rs.git",
    tag:      "0.1.0",
    revision: "9318cd6aa9cf0b2fa956308b2219c320b33fce1c"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  def install
    # prevent unnecessarily re-downloading rust toolchain
    ENV["CARGO_HOME"] = "#{HOMEBREW_CACHE}/cargo_cache"
    ENV.prepend_path "PATH", "#{HOMEBREW_CACHE}/cargo_cache/bin"
    ENV["PREFIX"] = "#{HOMEBREW_PREFIX}"
    
    system "cargo", "install", *std_cargo_args

    (etc/"update-motd.d").mkpath
    on_macos do
      (etc/"update-motd.d").install Dir["samples/macOS/*"]
    end
  end

  def caveats
    <<~EOS
      Add the following lines to your ~/.bash_profile:
        # Dynamic MOTD
        [[ -e "#{HOMEBREW_PREFIX}/bin/motd" ]] && #{HOMEBREW_PREFIX}/bin/motd
    EOS
  end

  test do
    system "motd", "--path"
    system "test", "-d", "#{etc}/update-motd.d"
  end
end

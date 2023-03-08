class UpdateMotd < Formula
  desc "Dynamic MOTD generation"
  homepage "https://github.com/ianmclinden/motd-rs"
  head "https://github.com/ianmclinden/motd-rs.git", branch:"main"
  url "https://github.com/ianmclinden/motd-rs.git",
    tag:      "0.2.2",
    revision: "710cdefd37afea66389ebbfb767b1ea05e702b8b"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  def install
    # prevent unnecessarily re-downloading rust toolchain
    ENV["CARGO_HOME"] = "#{HOMEBREW_CACHE}/cargo_cache"
    ENV.prepend_path "PATH", "#{HOMEBREW_CACHE}/cargo_cache/bin"
    ENV["PREFIX"] = "#{HOMEBREW_PREFIX}"
    
    system "cargo", "install", *std_cargo_args

    # macOS specific tools
    on_macos do
      system "cargo", "install", "--locked", "--root", prefix, "--path", "tools/macOS"
    end

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

  service do
    if OS.mac?
      run [opt_bin/"update-notifier"]
      run_type :interval
      interval 900
      environment_variables PATH: std_service_path_env
    end
  end
  
  test do
    system "motd", "--path"
    system "test", "-d", "#{etc}/update-motd.d"
    system "update-notifier", "--stamp"
  end
end

class Himbsay < Formula
  desc "A talking isaak and a talking guner. Like an overly-specific cowsay."
  homepage "https://github.com/ianmclinden/himbsay"
  head "https://github.com/ianmclinden/himbsay.git", branch:"main"
  url "https://github.com/ianmclinden/himbsay.git",
    tag:      "v0.6.0",
    revision: "fe56ddde5a2b56c19629da9bae04319d9f62f217"
  license "MIT"
  
  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.version=#{version}", "-o", bin/"isaaksay", "./cmd/isaaksay/isaaksay.go"
    system "go", "build", "-ldflags", "-X main.version=#{version}", "-o", bin/"gunersay", "./cmd/gunersay/gunersay.go"
  end

  test do
    system "isaaksay", "-v"
    system "gunersay", "-v"
  end
end

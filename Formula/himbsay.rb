class Himbsay < Formula
  desc "A talking isaak and a talking guner. Like an overly-specific cowsay."
  homepage "https://github.com/ianmclinden/himbsay"
  head "https://github.com/ianmclinden/himbsay.git", branch:"main"
  url "https://github.com/ianmclinden/himbsay.git",
    tag:      "v0.5.0",
    revision: "42d40a85037e3131aa99e1e571560dca7109c927"
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

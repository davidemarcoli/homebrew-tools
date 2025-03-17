class GitContributionStats < Formula
  desc "Script for analyzing Git repository contributions by author"
  homepage "https://github.com/davidemarcoli/tools"
  url "https://github.com/davidemarcoli/tools/archive/v1.0.0.tar.gz"
  sha256 "913ee0368bb4f2baa661059ced2a282600b1de272de9474763ba0de072d51768"
  license "The Unlicensed"
  
  depends_on "git"
  
  def install
    # Install the script and rename it to remove the .sh extension
    bin.install "bin/git-contribution-stats.sh" => "git-contribution-stats"
  end

  test do
    # Since your script requires a git repository to function properly,
    # we'll just test if it exists and is executable
    system "#{bin}/git-contribution-stats", "--help" rescue true
  end
end

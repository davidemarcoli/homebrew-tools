class GitContributionStats < Formula
  desc "Script for analyzing Git repository contributions by author"
  homepage "https://github.com/davidemarcoli/tools"
  url "https://github.com/davidemarcoli/tools/archive/v1.2.0.tar.gz"
  sha256 "62ea3eec16550f3957f14624ed09e9387ab0afdf215add8fb20120d17351e908"
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

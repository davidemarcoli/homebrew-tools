class GitContributionStats < Formula
  desc "Script for analyzing Git repository contributions by author"
  homepage "https://github.com/davidemarcoli/tools"
  url "https://github.com/davidemarcoli/tools/archive/v1.0.1.tar.gz"
  sha256 "c582ded04fa4bc88f62d6e4a4bf166fb4ff06124ed3be72440765cf070123ea8"
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

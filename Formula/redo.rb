class Redo < Formula
  desc "Small script that executes any program recursively in a directory tree"
  homepage "https://vbwx.github.io/redo/"
  url "https://github.com/vbwx/redo.git", tag: "v2.3"
  license "MIT"
  head "https://github.com/vbwx/redo.git", branch: "master"

  def install
    bin.install "redo"
    bash_completion.install "completion/redo"
    zsh_completion.install "completion/_redo"
  end

  test do
    mkdir "x"
    output = shell_output("#{bin}/redo x echo \\$DIR \\$LEAF")
    assert_equal("x 1", output)
  end
end

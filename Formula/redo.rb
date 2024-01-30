class Redo < Formula
  desc "Tiny program that executes any script or program recursively in a directory tree"
  homepage "https://vbwx.github.io/redo/"
  url "https://github.com/vbwx/redo.git", tag: "v1.4.2"
  license "MIT"
  head "https://github.com/vbwx/redo.git", branch: "master"

  def install
    bin.install "redo"
    bash_completion.install "completion/redo"
    zsh_completion.install "completion/_redo"
  end

  test do
    mkdir "x"
    output = shell_output("#{bin}/redo <<< 'echo $DIR'")
    assert_match(/^x$/, output)
  end
end

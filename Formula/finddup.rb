class Finddup < Formula
  desc "Finds duplicated files fast and efficiently"
  homepage "https://vbwx.github.io/finddup/"
  url "https://github.com/vbwx/finddup/archive/refs/tags/v1.12.5.tar.gz"
  sha256 "2bbbf4951d01a90df031ffbbd16272f5bc2ca6bcb035dad47a364bd90bd93e56"
  license "MIT"
  head "https://github.com/vbwx/finddup.git", branch: "main"

  uses_from_macos "perl"

  resource "Text::Glob" do
    url "https://cpan.metacpan.org/authors/id/R/RC/RCLAMP/Text-Glob-0.11.tar.gz"
    sha256 "069ccd49d3f0a2dedb115f4bdc9fbac07a83592840953d1fcdfc39eb9d305287"
  end

  resource "Sort::Key" do
    url "https://cpan.metacpan.org/authors/id/S/SA/SALVA/Sort-Key-1.33.tar.gz"
    sha256 "ed6a4ccfab094c9cd164f564024e98bd21d94f4312ccac4d6246d22b34081acf"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", libexec/"lib"
    ENV["PERL_MM_USE_DEFAULT"] = "1"

    resources.each do |r|
      r.stage do
        if File.exist? "Makefile.PL"
          system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
          system "make"
          system "make", "install"
        else
          system "perl", "Build.PL", "--install_base", libexec
          system "./Build"
          system "./Build", "install"
        end
      end
    end

    system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
    system "make"
    system "make", "install"

    bin.install "finddup"
    bin.env_script_all_files(libexec/"bin", PERL5LIB: ENV["PERL5LIB"])
    man1.install libexec/"man/man1/finddup.1"
    bash_completion.install "completion/finddup"
    zsh_completion.install "completion/_finddup"
  end

  test do
    touch ["a", "b"]
    output = shell_output("#{bin}/finddup -o")
    assert_equal("b", output)
  end
end

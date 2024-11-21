class RustyPsql < Formula
  desc "Wrapper around psql where connection information is pulled from Azure Key Vault"
  homepage "https://github.com/kometen/rusty-psql"
  url "https://github.com/kometen/rusty-psql/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "22b58286986cf3121f638022ca4e6be953d8755e434e3943f22d2c71c4abd6ba"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    # Install binary
    bin.install "target/release/rusty_psql"
  end

  test do
    output = shell_output("#{opt_bin}/rusty_psql --help | /usr/bin/head -1 | tr -d '\n' 2>&1")
    expected = "Usage: rusty_psql --namespace <NAMESPACE>"
    assert_match expected, output

    assert_match version.to_s, shell_output("#{opt_bin}/rusty_psql --version")
  end
end

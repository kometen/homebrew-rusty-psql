class RustyPsql < Formula
  desc "Wrapper around psql where connection information is pulled from Azure Key Vault"
  homepage "https://github.com/kometen/rusty-psql"
  url "https://github.com/kometen/rusty-psql/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "7341a60f81b09f25402b6bd768d06c41b45489e3cb50b1e89221181e09cb5ac6"
  license "MIT"

  depends_on "rust" => :build
  depends_on "openssl@3.4"

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

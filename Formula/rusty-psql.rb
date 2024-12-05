class RustyPsql < Formula
  desc "Wrapper around psql where connection information is pulled from Azure Key Vault"
  homepage "https://github.com/kometen/rusty-psql"
  url "https://github.com/kometen/rusty-psql/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "7341a60f81b09f25402b6bd768d06c41b45489e3cb50b1e89221181e09cb5ac6"
  license "MIT"

  bottle do
    root_url "https://github.com/kometen/homebrew-rusty-psql/releases/download/rusty-psql-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "66ce1cb6d8223d13c3d94b5a540621b0b278716a0dcbcf7fddef8426a4b23837"
    sha256 cellar: :any_skip_relocation, ventura:       "8f4713c59242a715bc80071fad82ac9b13cff7e4fc009768a8f5c6708d093609"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6aea8eefd129c58866857d6f30e5ac100b87c82cb1462caacff3b255ad27fdb5"
  end

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

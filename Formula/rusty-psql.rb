class RustyPsql < Formula
  desc "Wrapper around psql where connection information is pulled from Azure Key Vault"
  homepage "https://github.com/kometen/rusty-psql"
  url "https://github.com/kometen/rusty-psql/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "22b58286986cf3121f638022ca4e6be953d8755e434e3943f22d2c71c4abd6ba"
  license "MIT"

  bottle do
    root_url "https://github.com/kometen/homebrew-rusty-psql/releases/download/rusty-psql-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b68758aefae894225d46bd06a818d31175841dcae4203d76e5447b25b1a53800"
    sha256 cellar: :any_skip_relocation, ventura:       "1bd2e07da4f4d2019522285139dc9a343d24b4b32ba298527618b929f6a648c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c00280866b6d877b0f8981574dd3c9ebd7043c6e4cbb1a806264fbc3643231b"
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

{ pkgs, ... }:

let
  rustToolchain = pkgs.rust-bin.selectLatestNightlyWith (
    toolchain:
    toolchain.default.override {
      extensions = [
        "rust-src"
        "rust-analyzer"
      ];
      targets = [ "${pkgs.stdenv.hostPlatform.config}" ];
    }
  );
in
{
  packages = [
    rustToolchain
    pkgs.stdenv.cc
    pkgs.cargo-generate
    pkgs.pkg-config
  ];

  env = [
    {
      name = "RUST_LOG";
      value = "debug";
    }
  ];
}

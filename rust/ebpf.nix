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

  rustPlatform = pkgs.makeRustPlatform {
    rustc = rustToolchain;
    cargo = rustToolchain;
  };

  bpf-linker = pkgs.bpf-linker.override {
    inherit rustPlatform;
    rustc = pkgs.rustc // {
      llvm = pkgs.llvmPackages_22.llvm;
      llvmPackages = pkgs.llvmPackages_22;
    };
  };
in
{
  # In devshell, packages replaces buildInputs
  packages = [
    rustToolchain
    bpf-linker
    pkgs.llvmPackages_22.llvm
    pkgs.llvmPackages_22.clang
    pkgs.libelf
    pkgs.zlib
    pkgs.cargo-generate
    pkgs.iproute2
    pkgs.pkg-config
  ];

  # In devshell, env handles exports elegantly
  env = [
    {
      name = "LIBELF_FLAGS";
      value = "-lelf";
    }
    {
      name = "RUST_LOG";
      value = "debug";
    }
  ];
}

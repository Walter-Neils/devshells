{ pkgs }:

let
  rustToolchain = pkgs.rust-bin.selectLatestNightlyWith (toolchain:
    toolchain.default.override {
      extensions = [ "rust-src" "rust-analyzer" ];
      # Dynamic target selection based on what system is being evaluated
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
pkgs.mkShell {
  name = "rust-ebpf-nightly";

  buildInputs = with pkgs; [
    rustToolchain
    bpf-linker

    llvmPackages_22.llvm
    llvmPackages_22.clang
    libelf
    zlib

    cargo-generate
    iproute2
    pkg-config
  ];

  shellHook = ''
    export LIBELF_FLAGS="-lelf"
    export RUST_LOG=debug
    echo "env: RUST_LOG=$RUST_LOG"
    echo "env: LIBELF_FLAGS=$LIBELF_FLAGS"
    echo "version: cargo: $(cargo -V)"

  '';
}

{
  description = "Walter's DevShells";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      devshell,
      rust-overlay,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [
          (import rust-overlay)
          devshell.overlays.default
        ];
        pkgs = import nixpkgs { inherit system overlays; };
      in
      {
        devShells = {
          rust-ebpf = pkgs.devshell.mkShell { imports = [ ./rust/ebpf.nix ]; };
          rust-standard = pkgs.devshell.mkShell { imports = [ ./rust/standard.nix ]; };
          rust-gtk4 = pkgs.devshell.mkShell { imports = [ ./rust/gtk4.nix ]; };
          nodejs-standard = pkgs.devshell.mkShell { imports = [ ./nodejs/standard.nix ]; };
          cpp-standard = pkgs.devshell.mkShell { imports = [ ./cpp/standard.nix ]; };
        };
      }
    );
}

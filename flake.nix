{
  description = "Walter's DevShells";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Apply the rust-overlay to our standard pkgs
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
      in {
        devShells = {
          # Import the eBPF shell, passing our overlay-aware pkgs 
          rust-ebpf = import ./rust/ebpf.nix { inherit pkgs; };
          nodejs-standard = import ./nodejs/standard.nix { inherit pkgs; };
        };
      }
    );
}

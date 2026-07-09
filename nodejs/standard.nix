{ pkgs, ... }: {
  packages = with pkgs; [
    nodejs_20
    nodePackages.pnpm
    nodePackages.typescript-language-server
  ];
}

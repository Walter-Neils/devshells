{ pkgs, ... }:
{
  name = "GTK4 Rust DevShell";
  imports = [ ./standard.nix ];
  packages = [
    pkgs.gtk4
    pkgs.glib
    pkgs.libadwaita

    pkgs.adwaita-icon-theme
    pkgs.gsettings-desktop-schemas
  ];
}

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
  env = [
    {
      name = "PKG_CONFIG_PATH";
      value = "${pkgs.gtk4}/lib/pkgconfig:${pkgs.libadwaita}/lib/pkgconfig:${pkgs.glib.dev}/lib/pkgconfig";
    }

    {
      name = "XDG_DATA_DIRS";
      value = "$GSETTINGS_SCHEMAS_PATH:$XDG_DATA_DIRS";
    }
  ];
}

{ pkgs, ... }:

{
  gtk.enable = true;

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };
}

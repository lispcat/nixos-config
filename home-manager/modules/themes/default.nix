{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  gtk = {
    enable = true;
    
    theme.name = "catppuccin-macchiato-mauve-standard";
    theme.package = pkgs.catppuccin-gtk.override {
      variant = "macchiato";
      accents = [ "mauve" ];
    };

    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;

    cursorTheme.name = "default";
  };
}

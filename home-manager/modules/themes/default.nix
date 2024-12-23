{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  gtk = {
    enable = true;

    # theme.name = "orchis-dark-compact";
    # theme.package = pkgs.orchis-theme;

    theme.name = "Adwaita-dark";
    theme.package = pkgs.gnome-themes-extra;
    
    # theme.name = "Catppuccin-Macchiato-Mauve-Compact";
    # theme.package = pkgs.catppuccin-gtk.override {
    #   variant = "macchiato";
    #   accents = [ "mauve" ];
    #   # size = "compact";
    # };

    # iconTheme.name = "Papirus-Dark";
    # iconTheme.package = pkgs.papirus-icon-theme;

    # cursorTheme.name = "default";
  };
}

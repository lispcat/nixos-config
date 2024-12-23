{ pkgs, ... }:

{

  home.packages = with pkgs; [
    catppuccin-gtk
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    glib # gsettings
  ];

  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    NIXOS_OZONE_WL = "1";

    GDK_BACKEND = "wayland";
    ANKI_WAYLAND = "1";
    # WLR_DRM_NO_ATOMIC = "1";
    # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "xcb";
    # QT_STYLE_OVERRIDE = "kvantum";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_BACKEND = "vulkan";
    WLR_RENDERER = "vulkan";
    # WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
	      gtk-theme = "Adwaita-dark";
	      color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "Adwaita-dark";
    style = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
	#     gtk-theme = "adw-gtk3-dark";
	#     color-scheme = "prefer-dark";
  #   };
  # };

  # home.file.".gtkrc-2.0".text = ''
  #   gtk-theme-name = "Adwaita-dark"
  #   gtk-key-theme-name = "Emacs"
  # '';

  # gtk = {
  #   enable = true;

  #   theme = {
  #     name = "Gruvbox-Green-Dark";
  #     package = pkgs.gruvbox-gtk-theme.override {
  #       colorVariants = [ "dark" ];
  #       themeVariants = [ "green" ];
  #     };
  #   };
  # };

    # theme = {
    #   name = "Catppuccin-Mocha-Mauve-Standard";
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = [ "mauve" ];
    #     size = "standard";
    #     variant = "mocha";
    #   };
    # };
    
    # iconTheme = {
    #   name = "Kanagawa";
    #   package = pkgs.kanagawa-icon-theme;
    # };
  # };

  # home.packages = with pkgs; [
  #   catppuccin-gtk
  # ];
  
  # gtk = {
  #   enable = true;
  #   theme.package = pkgs.gnome-themes-extra;
  #   theme.name = "Adwaita-dark";
  # };
  
  # theme.name = "orchis-dark-compact";
  # theme.package = pkgs.orchis-theme;
  
  # theme.name = "Catppuccin-Macchiato-Mauve-Compact";
  # theme.package = pkgs.catppuccin-gtk.override {
  #   variant = "macchiato";
  #   accents = [ "mauve" ];
  #   # size = "compact";
  # };

  # iconTheme.name = "Papirus-Dark";
  # iconTheme.package = pkgs.papirus-icon-theme;

  # cursorTheme.name = "default";
  # };
  
  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk";
  #   style.name = "adwaita-dark";
  # };

}

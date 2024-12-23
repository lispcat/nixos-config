{ pkgs, ... }:

{

  home.packages = with pkgs; [
    glib # gsettings
  ];

  home.sessionVariables = {
    # GTK_THEME = "Adwaita-dark";
    # GTK_THEME = "Catppuccin-Macchiato-Mauve";
    NIXOS_OZONE_WL = "1";  # enable native wayland on chromium/electron

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

  ## qt

  qt.enable = true;
  
  qt = {
    platformTheme.name = "Adwaita-dark";
    style = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  ## gtk

  gtk.enable = true;

  gtk.iconTheme = {
    name = "Kanagawa";
    package = pkgs.kanagawa-icon-theme;
  };
  

  # comfy but hard to read
  # gtk.theme = {
  #   name = "catppuccin-mocha-mauve-compact";
  #   package = pkgs.catppuccin-gtk.override {
  #     variant = "mocha";
  #     accents = [ "mauve" ];
  #     size = "compact";
  #   };
  # };
  
  # comfy, somewhat good to read
  gtk.theme = {
    name = "Matcha-dark-pueril";
    package = pkgs.matcha-gtk-theme;
  };
  
  # simple grey, easy to read
  # gtk.theme = {
  #   name = "vimix-dark-compact-beryl";
  #   package = pkgs.vimix-gtk-themes.override {
  #     themeVariants = [ "beryl" ];
  #     colorVariants = [ "dark" ];
  #     sizeVariants = [ "compact" ];
  #     tweaks = [ "flat" ];
  #   };
  # };

  # kinda nice
  # gtk.theme = {
  #   name = "Materia-dark-compact";
  #   package = pkgs.materia-theme;
  # };

  # mid
  # gtk.theme = {
  #   name = "Flat-Remix-GTK-Teal-Dark";
  #   package = pkgs.flat-remix-gtk;
  # };

  # gtk.theme = {
  #   name = "Adwaita-dark";
  #   package = pkgs.gnome-themes-extra;
  # };

  # gtk.theme = {
  #   name = "Nordic";
  #   package = pkgs.nordic-theme;
  # };
  
  # gtk.theme = {
  #   name = "Dracula";
  #   package = pkgs.dracula-theme;
  # };

  # unmaintained and blue but very very easy to read
  # gtk.theme = {
  #   name = "Vertex-Dark";
  #   package = pkgs.theme-vertex;
  # };

  # gtk.theme = {
  #   name = "Tokyonight-Dark-Storm";
  #   package = pkgs.tokyonight-gtk-theme.override {
  #     tweakVariants = [ "storm" ];
  #   };
  # };

  # gtk.theme = {
  #   name = "Gruvbox-Purple-Dark";
  #   package = pkgs.gruvbox-gtk-theme.override {
  #     themeVariants = [ "purple" ];
  #     colorVariants = [ "dark" ];
  #   };
  # };

  # gtk.theme = {
  #   name = "Nightfox-Dark";
  #   package = pkgs.nightfox-gtk-theme;
  # };

  # gtk.theme = {
  #   name = "Arc-dark";
  #   package = pkgs.arc-theme;
  # };
  
}

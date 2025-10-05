{ pkgs, config, ... }:

{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-fluent
        fcitx5-configtool
        fcitx5-gtk
      ];
    };
  };

  home.file.".config/fcitx5/conf/classicui.conf".source =
    pkgs.writeText "classicui.conf" ''
      Theme=FluentDark-solid
    '';
}

{ pkgs, config, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      # fcitx5-gtk
      fcitx5-fluent
    ];
  };

  home.file.".config/fcitx5/conf/classicui.conf".source =
    pkgs.writeText "classicui.conf" ''
      Theme=FluentDark-solid
    '';
}

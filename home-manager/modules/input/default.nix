{ pkgs, config, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-material-color
    ];
  };

  home.file.".config/fcitx5/conf/classicui.conf".source =
    ./classicui.conf;
}

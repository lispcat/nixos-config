{ pkgs, ... }:

{
  services.xserver.xkb = { # kblayout
    layout = "us";
    variant = "dvp";
    options = "ctrl:nocaps";  # different for wayland comp
  };
  console = {
    useXkbConfig = true;
    earlySetup = true;  # for grub?
  };

  # i18n.inputMethod = {
  #   type = "fcitx5";
  #   enable = true;
  #   fcitx5.addons = with pkgs; [
  #     fcitx5-mozc
  #     fcitx5-gtk
  #     fcitx5-material-color
  #   ];
  # };
}

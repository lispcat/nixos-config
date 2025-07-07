{ pkgs, config, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };
}

{ pkgs, ... }:

let
  runcmd =
    "${pkgs.tuigreet}/bin/tuigreet --cmd " +
    "'zsh -l -c Hyprland'";
in
{
  services.greetd = {
    enable = true;
    settings.default_session.command = runcmd;
  };
  security.pam.services = {
    swaylock.text = ''
      auth include login
    '';
    waylock.text = ''
      auth include login
    '';
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}

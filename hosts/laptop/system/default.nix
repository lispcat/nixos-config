{ user, config, lib, inputs, ... }:

{
  ## Hardware Configuration
  imports = [
    ./hardware-configuration.nix
    ./hardware-tweaks.nix
    ./packages-temp.nix # TODO: move these
  ];

  ## Flags
  # (no need to specify config prefix, because that's the
  # final state of the ENTIRE flake config)

  ## System Flags
  features = {
    # global
    global.enable = true;
    # applications
    virtualization.enable = true;
    flatpak.enable = false;
    gtk-portal.enable = false;
    wlr-portal.enable = false;
    # firejail
    firejail.enable = true;
    # games
    games.enable = true;
    # hardware
    laptop-power.enable = true;
    # misc
    nix-ld.enable = false;
    # networking
    mullvad.enable = false;
    bluetooth.enable = false;
    dns-over-https.enable = false;
    # renoise
    renoise.enable = true;
    # wayland
    hyprland.enable = true;
    # zsh
    zsh.enable = true;
  };

  ## Host-specific configs
  boot = {
    kernel.sysctl = { "vm.swappiness" = lib.mkForce 1; };
    blacklistedKernelModules = [ "uvcvideo" ]; # disables webcam
  };

  ## Temp
  programs.wireshark.enable = true;

}

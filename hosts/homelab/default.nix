{ pkgs, user, config, lib, inputs, ... }:

{
  ## Hardware Configuration
  imports = [
    ./hardware-configuration.nix
    ./packages-temp.nix
  ];

  ## Flags
  # (no need to specify config prefix, because that's the
  # final state of the ENTIRE flake config)

  ## Home Flags
  home-manager.users.${user}.features = {
    ## Audio
    mpd.enable = false;
    ## Cron
    cron-hyprpaper.enable = false;
    cron-low-bat.enable = false;
    ## Dev
    git.enable = true;
    dev-env.enable = true;
    tmux.enable = true;
    gpg.enable = true;
    ## Dotfiles
    dotfiles.enable = true;
    ## Shells
    zsh.enable = true;
    ## Themes
    app-theme-def.enable = true;
    ## Xkb
    fcitx.enable = false;
  };

  ## System Flags
  features = {
    ## Global
    global.enable = true;
    ## Applications
    virtualization.enable = false;
    flatpak.enable = false;
    gtk-portal.enable = false;
    wlr-portal.enable = false;
    ## Firejail
    firejail.enable = true;
    ## Games
    games.enable = true;
    ## Hardware
    laptop-power.enable = false;
    ## Misc
    nix-ld.enable = false;
    ## Networking
    mullvad.enable = false;
    bluetooth.enable = false;
    dns-over-https.enable = false;
    ## Renoise
    renoise.enable = false;
    ## Wayland
    hyprland.enable = true;
    ## Zsh
    zsh.enable = true;
  };

  ## Host-specific configs

  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    blacklistedKernelModules = [ "uvcvideo" ]; # disables webcam
  };

  # Auto-login
  services.getty.autologinUser = "rin";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # Don't touch!
  system.stateVersion = "25.05"; # Did you read the comment?
}

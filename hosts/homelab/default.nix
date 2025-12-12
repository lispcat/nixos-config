{ pkgs, user, config, lib, inputs, ... }:

{
  ## Hardware Configuration
  imports = [
    ./hardware-configuration.nix
    # ./packages-temp.nix # TODO: move these
  ];

  ## Flags
  # (no need to specify config prefix, because that's the
  # final state of the ENTIRE flake config)

  ## Home Flags
  home-manager.users.${user}.features = {
    # audio
    mpd.enable = false;
    # cron
    cron-hyprpaper.enable = false;
    cron-low-bat.enable = false;
    # dev
    git.enable = true;
    dev-env.enable = true;
    tmux.enable = true;
    gpg.enable = true;
    # dotfiles
    dotfiles.enable = true;
    # shells
    zsh.enable = true;
    # themes
    app-theme-def.enable = true;
    # xkb
    fcitx.enable = false;
  };

  ## System Flags
  features = {
    # global
    global.enable = true;
    # applications
    virtualization.enable = false;
    flatpak.enable = false;
    gtk-portal.enable = false;
    wlr-portal.enable = false;
    # firejail
    firejail.enable = true;
    # games
    games.enable = true;
    # hardware
    laptop-power.enable = false;
    # misc
    nix-ld.enable = false;
    # networking
    mullvad.enable = false;
    bluetooth.enable = false;
    dns-over-https.enable = false;
    # renoise
    renoise.enable = false;
    # wayland
    hyprland.enable = true;
    # zsh
    zsh.enable = true;
  };

  ## Host-specific configs
  boot = {
    blacklistedKernelModules = [ "uvcvideo" ]; # disables webcam
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    ### Basic ###

    home-manager
    vim
    git
    tree
    emacs
    fzf
    fd
    trash-cli
    neovim
    alacritty
    mpv
    btop
    htop
    glances
    nethogs
    ffmpeg
    yt-dlp
    croc
    exiftool
    ripgrep
    tldr
    cmake
    # findutils

    ### Applications ###

    librewolf

  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable automatic login for the user.
  services.getty.autologinUser = "rin";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # Don't touch!
  system.stateVersion = "25.05"; # Did you read the comment?
}

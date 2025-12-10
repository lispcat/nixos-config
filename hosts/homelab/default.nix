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
    hyprland.enable = false;
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

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "America/New_York";

  # # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";

  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "en_US.UTF-8";
  #   LC_IDENTIFICATION = "en_US.UTF-8";
  #   LC_MEASUREMENT = "en_US.UTF-8";
  #   LC_MONETARY = "en_US.UTF-8";
  #   LC_NAME = "en_US.UTF-8";
  #   LC_NUMERIC = "en_US.UTF-8";
  #   LC_PAPER = "en_US.UTF-8";
  #   LC_TELEPHONE = "en_US.UTF-8";
  #   LC_TIME = "en_US.UTF-8";
  # };

  # # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "dvp";
  #   options = "ctrl:nocaps";
  # };
  # console = {
  #   useXkbConfig = true;
  #   earlySetup = true;
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.rin = {
  #   isNormalUser = true;
  #   description = "rin";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   packages = with pkgs; [];
  # };

  # Enable automatic login for the user.

  services.getty.autologinUser = "rin";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

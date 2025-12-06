{ pkgs, user, ... }:

{

  ### Shell #########################################################

  programs.zsh.enable = true;
  # Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;

    users.${user} = {
      isNormalUser = true;
      description = "${user}";
      extraGroups = [ "wheel" "wireshark" ];
    };
  };

  nix.settings.trusted-users = [ "root" "${user}" ];

  ### Keyboard ######################################################

  services.xserver.xkb = {
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

  ### Env Vars ######################################################

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };
}

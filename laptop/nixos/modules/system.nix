{ lib, user, pkgs, ... }:

let
  # DNS nameservers for services.resolved
  dns-list = [
    # "194.242.2.2#dns.mullvad.net"
    "194.242.2.3#adblock.dns.mullvad.net"
    # "194.242.2.4#base.dns.mullvad.net"
    # "194.242.2.5#extended.dns.mullvad.net"
    # "194.242.2.6#family.dns.mullvad.net"
    # "194.242.2.9#all.dns.mullvad.net"
    "94.140.15.15"
  ];

in {

  ### Performance ###################################################

  # thermald (prevent overheating)
  services.thermald.enable = true;

  # tlp (power saving)
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC  = "performance"  ;
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave"    ;
      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave"  ;

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      # save long term battery health
      START_CHARGE_THRESH_BAT0 = 70; # start charging at 40 and below
      STOP_CHARGE_THRESH_BAT0  = 90; # stop charging at 95 and above
    };
  };

  services.upower = {
    enable = true;
    criticalPowerAction = "HybridSleep";
  };

  ### Networking ####################################################

  ### DNS over HTTPS and DNS over TLS

  # networking.networkmanager.dns = "systemd-resolved";
  # networking.nameservers = dns-list;
  # networking.resolvconf.useLocalResolver = true;
  # services.resolved = {
  #   enable = true;
  #   dnssec = "false";
  #   # dnssec = "true";
  #   dnsovertls = "true";
  #   domains = [ "~." ];
  #   fallbackDns = dns-list;
  # };

  ### Connectivity

  # Enable networking
  networking.networkmanager.enable = true;
  # Define your hostname.
  networking.hostName = "NixOwOs";

  # ?
  users.users.${user}.extraGroups = [ "audio" ];

  #### Mullvad

  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = true;
    package = pkgs.mullvad-vpn;
  };

  ### Bluetooth

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    Policy = {
      AutoEnable = true;
    };
  };

  ### Linux #########################################################

  # polkit (dont really know what this does)
  security.polkit.enable = true;

  # some programs depend on it i think
  services.dbus.enable = true;

  services = {
    # mounting disks
    udisks2.enable = true;
  };

  boot = {
    tmp.cleanOnBoot = true;
    kernel.sysctl = { "vm.swappiness" = lib.mkForce 1; };
    blacklistedKernelModules = [ "uvcvideo" ]; # disables webcam
  };

  ### NixOS Store ###################################################

  # auto-gc every week
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      keep-failed = true;
      download-buffer-size = 524288000;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}

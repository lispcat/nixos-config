{ pkgs, user, ... }:

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
in
{
  
  # ### DNS over HTTPS and DNS over TLS
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

  ### Network
  
  # Enable networking
  networking.networkmanager.enable = true;
  # Define your hostname.
  networking.hostName = "NixOwOs";
  
  # ?
  users.users.${user}.extraGroups = [ "audio" ];

  ### mullvad
  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = true;
    package = pkgs.mullvad-vpn;
  };
}


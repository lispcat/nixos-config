{ pkgs, lib, ... }:

{
  ## Steam

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    localNetworkGameTransfers.openFirewall = false;
  };
  
  nixpkgs.allowUnfreePackages = [
    "steam"
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];
  
  programs.firejail.wrappedBinaries.steam = {
    executable = "${pkgs.steam}/bin/steam";
    profile = "${pkgs.firejail}/etc/firejail/steam.profile";
  };
  programs.firejail.wrappedBinaries.steam-run = {
    executable = "${pkgs.steam}/bin/steam-run";
    profile = "${pkgs.firejail}/etc/firejail/steam.profile";
  };
  
  environment.etc = {
    "firejail/steam.local".text = ''
      # Allow VR and camera-based motion tracking
      ignore novideo
      # seccomp sometimes causes issues...
      ignore seccomp
      # private-etc breaks a small handful of games...
      ignore private-etc
      
      # whitelist dirs
      whitelist ''${HOME}/Games/
      whitelist ''${HOME}/Desktop/
    '';
  };

  environment.etc = {
    "firejail/prismlauncher.profile".text = ''
      # Firejail profile for PrismLauncher
      # Description: An Open Source Minecraft launcher with the ability to manage multiple instances, accounts and mods.
      # This file is overwritten after every install/update
      # Persistent local customizations
      include prismlauncher.local
      # Persistent global definitions
      include globals.local

      # Allow java (blacklisted by disable-devel.inc)
      include allow-java.inc

      include disable-common.inc
      include disable-interpreters.inc
      include disable-proc.inc
      include disable-shell.inc

      whitelist ''${HOME}/.local/share/PrismLauncher
      whitelist ''${HOME}/Downloads
      include whitelist-common.inc

      apparmor
      caps.drop all
      netfilter
      nodvd
      nogroups
      nonewprivs
      noprinters
      noroot
      # notpm
      notv
      nou2f
      protocol unix,inet,inet6
      seccomp
      seccomp.block-secondary

      disable-mnt
      private-cache
      private-dev
      private-tmp

      dbus-user none
      dbus-system none

      restrict-namespaces
    '';
  };

  ## Prismlauncher

  programs.firejail.wrappedBinaries.prismlauncher = {
    executable = "${pkgs.prismlauncher}/bin/prismlauncher";
    profile = "/etc/firejail/prismlauncher.profile";
  };

}

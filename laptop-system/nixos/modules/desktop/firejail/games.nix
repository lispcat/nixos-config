{ pkgs, pkgs-stable, ... }:

{
  ### general ###
  # nixpkgs.allowUnfreePackages = [
  #   "steam"
  #   "steam"
  #   "steam-original"
  #   "steam-unwrapped"
  #   "steam-run"
  #   "osu-lazer-bin"
  # ];

  ## Steam

  programs.steam = {
    enable = true;
    package = pkgs.steam;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    localNetworkGameTransfers.openFirewall = false;
  };

  environment.etc = {
    "firejail/steam.profile".source = ./files/steam.profile;
  };

  programs.firejail.wrappedBinaries.steam = {
    executable = "${pkgs.steam}/bin/steam";
    # profile = "/etc/firejail/steam.profile";
    profile = "${pkgs.firejail}/etc/firejail/steam.profile";
  };

  programs.firejail.wrappedBinaries.steam-run = {
    executable = "${pkgs.steam}/bin/steam-run";
    # profile = "/etc/firejail/steam.profile";
    profile = "${pkgs.firejail}/etc/firejail/steam.profile";
  };

  # environment.etc = {
  #   "firejail/steam.local".text = ''
  #     # Allow VR and camera-based motion tracking
  #     ignore novideo

  #     # seccomp sometimes causes issues...
  #     ignore seccomp

  #     # private-etc breaks a small handful of games...
  #     ignore private-etc

  #     # whitelist dirs
  #     whitelist ''${HOME}/Games/
  #     whitelist ''${HOME}/Desktop/
  #   '';
  # };

  ## Prismlauncher

  # environment.etc = {
  #   "firejail/prismlauncher.profile".text = ''
  #     # Firejail profile for PrismLauncher
  #     # Description: An Open Source Minecraft launcher with the ability to manage multiple instances, accounts and mods.
  #     # This file is overwritten after every install/update
  #     # Persistent local customizations
  #     include prismlauncher.local
  #     # Persistent global definitions
  #     include globals.local

  #     # Allow java (blacklisted by disable-devel.inc)
  #     include allow-java.inc

  #     include disable-common.inc
  #     include disable-interpreters.inc
  #     include disable-proc.inc
  #     include disable-shell.inc

  #     whitelist ''${HOME}/.local/share/PrismLauncher
  #     whitelist ''${HOME}/Downloads
  #     include whitelist-common.inc

  #     apparmor
  #     caps.drop all
  #     netfilter
  #     nodvd
  #     nogroups
  #     nonewprivs
  #     noprinters
  #     noroot
  #     # notpm
  #     notv
  #     nou2f
  #     protocol unix,inet,inet6
  #     seccomp
  #     seccomp.block-secondary

  #     disable-mnt
  #     private-cache
  #     private-dev
  #     private-tmp

  #     dbus-user none
  #     dbus-system none

  #     restrict-namespaces
  #   '';
  # };

  programs.firejail.wrappedBinaries.prismlauncher = {
    executable = "${pkgs.prismlauncher}/bin/prismlauncher";
    profile = "${pkgs.prismlauncher}/etc/firejail/prismlauncher.profile";
    # profile = "/etc/firejail/prismlauncher.profile";
  };

  # programs.firejail.wrappedBinaries.prismlauncher = {
  #   executable = "${pkgs.prismlauncher}/bin/prismlauncher";
  #   profile = "/etc/firejail/prismlauncher.profile";
  # };

  ## Osu-Lazer

  environment.systemPackages = with pkgs; [
    osu-lazer-bin
  ];

  environment.etc = {
    "firejail/osu-lazer.profile".text = ''
      # whitelist ~/./firejail/osulazer

      mkdir ~/.local/share/osu
      whitelist ~/.local/share/osu

      whitelist ~/.config

      ignore net none
      ignore no3d
      ignore nosound
      # TODO: What syscalls?
      ignore seccomp
      protocol unix,inet,inet6,netlink
      # include ~/.config/firejail/inc/firefox-escape.inc
      # include ~/.config/firejail/inc/discord-ipc.inc
      # include ~/.config/firejail/inc/default.inc
    '';
  };

  programs.firejail.wrappedBinaries."osu!" = {
    executable = "${pkgs.osu-lazer-bin}/bin/osu!";
    profile = "/etc/firejail/osu-lazer.profile";
  };
}

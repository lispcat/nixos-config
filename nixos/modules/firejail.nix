{ pkgs, ... }:

{
  # environment.systemPackages = with pkgs; [ firejail ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    localNetworkGameTransfers.openFirewall = false;
  };
  
  programs.firejail = {
    enable = true;
    
    wrappedBinaries = {
      steam = {
        executable = "${pkgs.steam}/bin/steam";
        profile = "${pkgs.firejail}/etc/firejail/steam.profile";
      };
      steam-run = {
        executable = "${pkgs.steam}/bin/steam-run";
        profile = "${pkgs.firejail}/etc/firejail/steam.profile";
      };
      prismlauncher = {
        executable = "${pkgs.prismlauncher}/bin/prismlauncher";
        profile = "${pkgs.firejail}/etc/firejail/prismlauncher.profile";
      };
      mpv = {
        executable = "${pkgs.mpv}/bin/mpv";
        profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
      };
      
    };
  };
}

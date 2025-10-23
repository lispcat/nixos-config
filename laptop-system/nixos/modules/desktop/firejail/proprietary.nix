{ pkgs, lib, ... }:

{
  programs.firejail.wrappedBinaries.spotify = {
    executable = "${pkgs.spotify}/bin/spotify";
    profile = "${pkgs.firejail}/etc/firejail/spotify.profile";
  };
  # nixpkgs.allowUnfreePackages = [ "spotify" ];
  environment.etc = {
    "firejail/spotify.local".text = ''
      # allow links that open in browser to access librewolf profiles
      noblacklist ''${HOME}/.librewolf
      whitelist ''${HOME}/.librewolf/profiles.ini
    '';
  };
}

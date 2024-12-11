{ pkgs, ... }:

{

  programs.firejail.enable = true;
  programs.firejail.wrappedBinaries = {
    mpv = {
      executable = "${pkgs.mpv}/bin/mpv";
      profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
    };
  };

  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    
  # ];
}

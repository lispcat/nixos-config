{ pkgs, ... }:

{
  # fix AX200 wifi issue
  boot.kernelModules = [ "iwlwifi" ];
  boot.extraModprobeConfig = ''
    options iwlwifi power_save=0
    options iwlmvm power_scheme=1
  '';
  
  services.btrfs = {
    autoScrub.enable = true;
  };
  
  services.fstrim = {
    enable = true;
  };
}

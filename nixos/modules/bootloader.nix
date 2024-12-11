{ pkgs, ... }:

{
  boot = {

    loader.grub = {
      enable = true;
      useOSProber = true;
      # device = <add in hardware configuration>
    };
  };
  
}

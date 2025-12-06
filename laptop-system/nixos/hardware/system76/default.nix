{
  imports = [
    ./hardware-configuration.nix
    ./system76.nix
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    Policy = {
      AutoEnable = true;
    };
  };
}

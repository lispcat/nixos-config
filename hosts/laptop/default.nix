{ config, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./hardware-tweaks.nix
  ];

  config.features = {
    ## gui
    # realtime
    renoise = true;

    ## cli

    ## system
    # pipewire

    # note: def
  };
}

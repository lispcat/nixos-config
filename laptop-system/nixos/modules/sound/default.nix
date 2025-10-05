{ inputs, ... }:

{
  imports = [
    ./pipewire.nix
    inputs.musnix.nixosModules.musnix
  ];

  musnix = {
    enable = true;
    rtcqs.enable = true;
    das_watchdog.enable = true; ## MAY CRASH VST???? MAYBE???
  };
}

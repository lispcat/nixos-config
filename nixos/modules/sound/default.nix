{ inputs, ... }:

{
  imports = [
    # ./audioprod
    # ./mpd
    ./pipewire.nix
    inputs.musnix.nixosModules.musnix
  ];
  disabledModules = [ ];

  musnix = {
    enable = true;
    rtcqs.enable = true;
    das_watchdog.enable = true; ## MAY CRASH VST???? MAYBE???
  };
}

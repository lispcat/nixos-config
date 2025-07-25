{
  imports = [
    # ./audioprod
    # ./mpd
    ./pipewire.nix
  ];
  disabledModules = [ ];

  ## TODO: MOVE ; audio stuff
  musnix = {
    enable = true;
    rtcqs.enable = true;
    das_watchdog.enable = true; ## MAY CRASH VST???? MAYBE???
  };
}

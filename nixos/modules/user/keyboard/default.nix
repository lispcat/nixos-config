{
  services.xserver.xkb = { # kblayout
    layout = "us";
    variant = "dvp";
    options = "ctrl:swapcaps";
  };
  console = {
    useXkbConfig = true;
    earlySetup = true;  # for grub?
  };
}

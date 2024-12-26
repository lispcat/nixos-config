{
  services.xserver.xkb = { # kblayout
    layout = "us";
    variant = "dvp";
    options = "ctrl:nocaps";  # different for wayland comp
  };
  console = {
    useXkbConfig = true;
    earlySetup = true;  # for grub?
  };
}

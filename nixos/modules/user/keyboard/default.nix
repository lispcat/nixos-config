{
  services.xserver.xkb = { # kblayout
    layout = "us";
    variant = "dvp";
    options = "caps:ctrl_modifier,shift:both_capslock_cancel";
  };
  console = {
    useXkbConfig = true;
    earlySetup = true;  # for grub?
  };
}

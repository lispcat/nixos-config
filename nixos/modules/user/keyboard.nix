{ ... }:

{
  services.xserver.xkb = { # kblayout
    layout = "us";
    variant = "dvp";
    options = "ctrl:nocaps";
  };
  console = {
    useXkbConfig = true;
    earlySetup = true;  # for grub?
  };
  
}

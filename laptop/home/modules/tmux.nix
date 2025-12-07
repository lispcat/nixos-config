{
  programs.tmux = {
    enable = true;
    prefix = "M-m";
    historyLimit = 10000;
    newSession = true;  # not needed?
    mouse = true;
    clock24 = true;
  };
}

{ home, ... }:

{
  "mpv" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/mpv";
  };
}

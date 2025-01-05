{ lib, config, ... }:

{
  home.file.".config/wlr-which-key/config.yaml".source =
    config.lib.file.mkOutOfStoreSymlink ./config.yaml;
}

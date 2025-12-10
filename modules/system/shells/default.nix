{ config, pkgs, mkFeature, ... }:

{
  imports = [
    (mkFeature "zsh" "Enable zsh for the main user" {
      ## TODO: make it so that multiple shells can be enabled
      ## at once, but a main user shell can be selected
      ## via some option.
      # basic setup
      programs.zsh.enable = true;

      # user default shell
      users.defaultUserShell = pkgs.zsh;
    })
  ];

  config.assertions = [
    {
      assertion = (
        config.features."zsh".enable
      );
      message = ''
        Must enable at least one shell
      '';
    }
  ];
}

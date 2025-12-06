{ inputs, user, ... }:

{
  imports =
    [ inputs.home-manager.nixosModules.home-manager ];

  home-manager =
    { useGlobalPkgs = true;  # use system pkgs
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs user; };
      users.${user} = { ... }:
        { imports =
            [ ./modules/default.nix
              ./dotfiles
              ./packages.nix ];

          home =
            { username = "sui";
              homeDirectory = "/home/sui";

              # This value determines the Home Manager release that your configuration is
              # compatible with. This helps avoid breakage when a new Home Manager release
              # introduces backwards incompatible changes.
              #
              # You should not change this value, even if you update Home Manager. If you do
              # want to update the value, then make sure to first check the Home Manager
              # release notes.
              stateVersion = "24.05"; }; }; };
}

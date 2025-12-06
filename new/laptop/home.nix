{ inputs, user, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;  # use system pkgs
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs user; };
    users.${user} = { ... }: {
      home = {
        username = "sui";
        homeDirectory = "/home/sui";
        stateVersion = "24.05"; # Configuration version
      };
      imports = [
        ./modules/default.nix
        ./dotfiles
        ./packages.nix
      ];
    };
  };
}

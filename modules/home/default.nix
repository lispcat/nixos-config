{ inputs, user, ... }:

let
  imports-deferred = [
    ./shells.nix
  ];
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;  # use system pkgs
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs user; };
    users.${user} = { ... }: {
      imports = imports-deferred;

      home = {
        username = "${user}";
        homeDirectory = "/home/${user}";

        # Don't touch!
        stateVersion = "24.05";
      };
    };
  };
}

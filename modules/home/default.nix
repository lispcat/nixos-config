{ inputs, user, mkFeature, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;  # use system pkgs
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs user mkFeature; };
    users.${user} = { ... }: {
      imports = [
        ./audio
        ./cron
        ./dev
        ./dotfiles
        ./shells
        ./themes
        ./xkb
      ];
      home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
        # Don't touch!
        stateVersion = "24.05";
      };
    };
  };
}

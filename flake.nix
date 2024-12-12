{
  description = "A very basic flake";

  ## Inputs:

  inputs = {
    
    # suckless repos (hardcoded paths)
    dwl-source.url = "/home/sui/flakes/dwl-fork";
    dwl-source.flake = false;
    dwlb-source.url = "/home/sui/flakes/dwlb-fork";
    dwlb-source.flake = false;
    slstatus-source.url = "/home/sui/flakes/slstatus-fork";
    slstatus-source.flake = false;

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  ## Outputs:

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, dwl-source, dwlb-source, slstatus-source, ... }@inputs:

    let
      system = "x86_64-linux";
      pkgs        = import nixpkgs        { inherit system; };
      pkgs-stable = import nixpkgs-stable { inherit system; };
    in {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system inputs;
        };
        
        modules = [ ./nixos/configuration.nix ];
      };

      homeConfigurations.sui = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit dwl-source dwlb-source slstatus-source;
        };
        
        modules = [ ./home-manager/home.nix ];
      };

      # end of in
    };
  # end of outputs
}

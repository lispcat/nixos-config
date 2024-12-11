{
  description = "A very basic flake";

  ## Inputs:

  inputs = {
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # suckless patched repos (as git subtrees)
    dwl-source = {
      url = "path:subtrees/dwl-fork";
      flake = false;
    };
    dwlb-source = {
      url = "path:subtrees/dwlb-fork";
      flake = false;
    };
    slstatus-source = {
      url = "path:subtrees/slstatus-fork";
      flake = false;
    };

    # end of inputs
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

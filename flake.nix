{
  description = "A very basic flake";

  ## Inputs:

  inputs = {

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # suckless repos (hardcoded paths)
    dwl-source = {
      url = "/home/sui/Src/dwl-fork";
      flake = false;
    };
    dwlb-source = {
      url = "/home/sui/Src/dwlb-fork";
      flake = false;
    };
    slstatus-source = {
      url = "/home/sui/Src/slstatus-fork";
      flake = false;
    };

  };

  ## Outputs:

  outputs =
    { self, nixpkgs, nixpkgs-stable, home-manager,
      dwl-source, dwlb-source, slstatus-source,
      unfree-merger, ... }@inputs:
    
    let
      system = "x86_64-linux";
      pkgs        = import nixpkgs        { inherit system; };
      pkgs-stable = import nixpkgs-stable { inherit system; };
      user = "sui";
    in {

      nixosConfigurations.NixOwOs = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system inputs user;
        };
        
        modules = [
          ./unfree-merger.nix
          ./nixos/configuration.nix
        ];
      };

      homeConfigurations.sui = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit dwl-source dwlb-source slstatus-source user;
        };
        
        modules = [
          ./unfree-merger.nix
          ./home-manager/home.nix
        ];
      };

      # end of in
    };
  # end of outputs
}

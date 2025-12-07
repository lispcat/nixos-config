{
  homelab-config-gen = { inputs, system, pkgs, pkgs-stable }:
    let
      user = "rin";
    in inputs.nixpkgs.lib.nixosSystem {
      inherit pkgs system;
      specialArgs = {
        inherit inputs user system pkgs-stable;
      };
      modules = [
        ./nixos
        ./home
      ];
    };

}

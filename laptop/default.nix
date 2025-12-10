{
  laptop-config-gen = { inputs, system, pkgs, pkgs-stable }:
    let
      user = "sui";
    in inputs.nixpkgs.lib.nixosSystem {
      inherit pkgs system;
      specialArgs =
        { inherit inputs user system pkgs-stable; };
      modules = [
        ./nixos
        ./home
      ];
    };
}

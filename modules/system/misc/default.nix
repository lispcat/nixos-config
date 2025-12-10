{ mkFeature, inputs, ... }:

{
  imports = [
    inputs.nix-ld.nixosModules.nix-ld # bring into scope

    (mkFeature "nix-ld" "Enable nix-ld" {
      programs.nix-ld.enable = true;
    })
  ];
}

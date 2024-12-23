{ pkgs, ... }:

{
  # use nix develop
  devShells.x86_64-linux.default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      rustc
      cargo
      rustfmt
      clippy
      rust-analyzer
    ];
  };
}

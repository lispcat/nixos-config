{ pkgs, ... }:

{
  home = {
    
    packages = with pkgs; [

      tree
      mpc

    ];
    
  };
}

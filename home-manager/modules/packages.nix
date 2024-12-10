{ pkgs, ... }:

{
  home = {
    
    # let
    #   suckless-overlay = final: prev: {
        
    #   };
    # in
      
    packages = with pkgs; [

      htop
      dwl

    ];
    
  };
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
    acpi
    emacs-lsp-booster

    # temp

  ];
}

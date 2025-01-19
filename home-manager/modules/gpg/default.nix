{ pkgs, config, ... }:

let
  gpgPkg = config.programs.gpg.package;
  setupScript = ''
    GPG_TTY="$(tty)"
    export GPG_TTY
    ${gpgPkg}/bin/gpg-connect-agent updatestartuptty /bye > /dev/null
  '';
in {
  programs.gpg = {
    enable = true;
  };
  home.packages = with pkgs; [
    pinentry
  ];
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSshSupport = true;
    # dont forget to run WM with zsh -l -c 's%'
    enableZshIntegration = true;
    enableExtraSocket = true;
    defaultCacheTtl = 28800;
    defaultCacheTtlSsh = 28800;
    maxCacheTtl = 28800;
    maxCacheTtlSsh = 28800;
    extraConfig = ''
      allow-emacs-pinentry
    '';
    sshKeys = [
      # Provide the keygrip
      "E853C145BE1BA0A27CD219E4AF2DB12D14AA6968"
      "5D3BF86600C933F67035FF3CE16C170065584BE8"
    ];
  };
}

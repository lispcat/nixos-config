{ pkgs, ... }:

{

  programs.firejail.enable = true;
  programs.firejail.wrappedBinaries = {
    mpv = {
      executable = "${pkgs.mpv}/bin/mpv";
      profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
    };
    # keepassxc = {
    #   executable = "${pkgs.keepassxc}/bin/keepassxc";
    #   profile = "${pkgs.firejail}/etc/firejail/keepassxc.profile";
    # };
  };

#   # keepassxc local
#   environment.etc = {
#     "firejail/keepassxc.local".text = ''
# # You can enable whitelisting for keepassxc by adding the below to your keepassxc.local.
# # If you do, you MUST store your database under ''${HOME}/Documents/KeePassXC/foo.kdbx.
# mkdir ''${HOME}/Private/secure
# whitelist ''${HOME}/Private/secure
# noblacklist ''${HOME}/Private

# # Needed for KeePassXC-Browser.

# mkdir ''${HOME}/.librewolf/native-messaging-hosts
# mkfile ''${HOME}/.librewolf/native-messaging-hosts/org.keepassxc.keepassxc_browser.json
# whitelist ''${HOME}/.librewolf/native-messaging-hosts/org.keepassxc.keepassxc_browser.json

# mkdir ''${HOME}/.config/chromium/NativeMessagingHosts
# mkfile ''${HOME}/.config/chromium/NativeMessagingHosts/org.keepassxc.keepassxc_browser.json
# whitelist ''${HOME}/.config/chromium/NativeMessagingHosts/org.keepassxc.keepassxc_browser.json
# mkdir ''${HOME}/.local/share/torbrowser/tbb/x86_64/tor-browser_en-US/Browser/TorBrowser/Data/Browser/.mozilla/native-messaging-hosts
# mkfile ''${HOME}/.local/share/torbrowser/tbb/x86_64/tor-browser_en-US/Browser/TorBrowser/Data/Browser/.mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json
# whitelist ''${HOME}/.local/share/torbrowser/tbb/x86_64/tor-browser_en-US/Browser/TorBrowser/Data/Browser/.mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json
# mkdir ''${HOME}/.mozilla/native-messaging-hosts
# mkfile ''${HOME}/.mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json
# whitelist ''${HOME}/.mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json
# mkdir ''${HOME}/.cache/keepassxc
# mkdir ''${HOME}/.config/keepassxc
# whitelist ''${HOME}/.cache/keepassxc
# whitelist ''${HOME}/.config/keepassxc
# whitelist ''${HOME}/.config/KeePassXCrc
# include whitelist-common.inc
# '';
#   };

  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    
  # ];
}

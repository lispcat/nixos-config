# Firejail profile for Renoise using Yabridge
#
# Start by including the official wine profile as a base.
# This gives us all the standard security and compatibility
# settings for Wine automatically.
include ${pkgs.firejail}/etc/firejail/wine.profile

# Now, simply add the extra directories needed for our DAW workflow.
whitelist ${HOME}/.local/share/Renoise
whitelist ${HOME}/Music
whitelist ${HOME}/.vst
whitelist ${HOME}/.vst3
whitelist ${HOME}/.clap

default: laptop-all-fancy

update:
	nix flake update

## laptop ##

laptop-sys:
	sudo nixos-rebuild switch --flake .#laptop-sys

laptop-sys-build:
	sudo nixos-rebuild build --flake .#laptop-sys

laptop-home:
	home-manager switch --flake .#laptop-home

laptop-home-build:
	home-manager build --flake .#laptop-home

laptop-all: laptop-sys laptop-home

laptop-all-fancy:
	sudo true && sudo nixos-rebuild switch --flake .#laptop-sys |& nom
	home-manager switch --flake .#laptop-home |& nom
	sudo nix-channel --update
	nix-env -u '*'

## Homelab ##

homelab-sys:
	sudo nixos-rebuild switch --flake .#homelab-sys

homelab-sys-build:
	sudo nixos-rebuild build --flake .#homelab-sys

homelab-home:
	home-manager switch --flake .#homelab-home

homelab-home-build:
	home-manager build --flake .#homelab-home

homelab-all: homelab-sys homelab-home

homelab-all-fancy:
	sudo true && sudo nixos-rebuild switch --flake .#homelab-sys |& nom
	home-manager switch --flake .#homelab-home |& nom
	sudo nix-channel --update
	nix-env -u '*'

## Misc ##

env:
	sudo nix-channel --update
	nix-env -u '*'

all: update env laptop-sys laptop-sys-build laptop-home laptop-home-build laptop-all laptop-all-fancy homelab-sys homelab-sys-build homelab-home homelab-home-build homelab-all homelab-all-fancy

.PHONY: default update sys home env

default: home

update:
	nix flake update

sys:
	sudo nixos-rebuild switch --flake .#laptop

sys-fancy:
	sudo true && sudo nixos-rebuild switch --flake .#laptop |& nom

lab:
	home-manager switch --flake .#homelab

env:
	sudo nix-channel --update
	nix-env -u '*'

all: update sys env

.PHONY: default update sys home env

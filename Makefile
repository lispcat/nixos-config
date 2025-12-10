default: home

update:
	nix flake update

main:
	sudo nixos-rebuild switch --flake .#laptop

main-fancy:
	sudo true && sudo nixos-rebuild switch --flake .#laptop |& nom

lab:
	home-manager switch --flake .#homelab

lab-fancy:
	sudo true && sudo nixos-rebuild switch --flake .#homelab |& nom

env:
	sudo nix-channel --update
	nix-env -u '*'

all: update main main-fancy lab lab-fancy env

.PHONY: default update sys home env

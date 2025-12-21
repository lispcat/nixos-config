default: home

update:
	nix flake update

laptop:
	sudo nixos-rebuild switch --flake .#laptop

laptop-fancy:
	sudo true && sudo nixos-rebuild switch --flake .#laptop |& nom
	sudo nix-channel --update
	nix-env -u '*'

laptop-build:
	sudo nixos-rebuild build --flake .#laptop

lab:
	home-manager switch --flake .#homelab

lab-fancy:
	sudo true && sudo nixos-rebuild switch --flake .#homelab |& nom
	sudo nix-channel --update
	nix-env -u '*'

lab-build:
	home-manager build --flake .#homelab

env:
	sudo nix-channel --update
	nix-env -u '*'

all: update laptop laptop-build laptop-fancy lab lab-build lab-fancy env

.PHONY: default update sys home env

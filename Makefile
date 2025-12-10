default: home

update:
	nix flake update

laptop-build:
	sudo nixos-rebuild build --flake .#laptop

laptop-fancy-build:
	sudo true && sudo nixos-rebuild build --flake .#laptop |& nom

lab-build:
	home-manager build --flake .#homelab

lab-fancy-build:
	sudo true && sudo nixos-rebuild build --flake .#homelab |& nom

# env:
# 	sudo nix-channel --update
# 	nix-env -u '*'

all: update laptop-build laptop-fancy-build lab-build lab-fancy-build # env

.PHONY: default update sys home env

default: home

update:
	nix flake update

sys:
	sudo nixos-rebuild switch --flake .#laptop-system

# home:
# 	home-manager switch --flake .#laptop-home

env:
	sudo nix-channel --update
	nix-env -u '*'

all: update sys env

.PHONY: default update sys home env

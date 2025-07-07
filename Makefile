default: home

update:
	nix flake update

sys:
	sudo nixos-rebuild switch --flake .#NixOwOs

home:
	home-manager switch --flake .#sui

env:
	sudo nix-channel --update
	nix-env -u '*'

all: update sys home env

.PHONY: default update sys home env

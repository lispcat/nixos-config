default: home

sys:
	sudo nixos-rebuild switch --flake .#NixOwOs

home:
	home-manager switch --flake .#sui

update:
	nix flake update

env:
	sudo nix-channel --update
	nix-env -u '*'


.PHONY: default sys home update

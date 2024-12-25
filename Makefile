default: home

sys:
	sudo nixos-rebuild switch --flake .#NixOwOs

home:
	home-manager switch --flake .#sui

update:
	nix flake update


.PHONY: default sys home update

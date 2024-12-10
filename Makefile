.PHONY: nixos home default

default: home

nixos:
	sudo nixos-rebuild switch --flake .

home:
	home-manager switch --flake .

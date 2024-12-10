.PHONY: default sys home

default: home

sys:
	sudo nixos-rebuild switch --flake .

home:
	home-manager switch --flake .

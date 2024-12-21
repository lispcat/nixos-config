
# ### Variables: ###

# repos_dir = /home/sui/flakes

# dwl_input      = dwl-source
# dwlb_input     = dwlb-source
# slstatus_input = slstatus-source

# dwl_path      = $(repos_dir)/dwl-fork
# dwlb_path     = $(repos_dir)/dwlb-fork
# slstatus_path = $(repos_dir)/slstatus-fork

# dwl_override      = $(call arg_template,$(dwl_input),$(dwl_path))
# dwlb_override     = $(call arg_template,$(dwlb_input),$(dwlb_path))
# slstatus_override = $(call arg_template,$(slstatus_input),$(slstatus_path))

# extra_args = $(dwl_override) $(dwlb_override) $(slstatus_override)

# ### Functions: ###

# define arg_template
# --override-input $(1) path:$(2)
# endef

### Targets: ###

default: home

# test:
# 	@echo $(extra_args)

sys:
	sudo nixos-rebuild switch --flake .#NixOwOs

home:
	home-manager switch --flake .#sui

update:
	nix flake update

suckless:
	nix flake update dwl-source dwlb-source slstatus-source


.PHONY: default sys home

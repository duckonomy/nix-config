.PHONY: update
update:
	home-manager switch --flake .#duckonomy@nixos --impure

.PHONY: update-nixos
update:
	nixos-rebuild switch --flake .#nixos --impure

.PHONY: clean
clean:
	nix-collect-garbage -d

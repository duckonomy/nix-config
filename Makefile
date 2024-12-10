.PHONY: update
update:
	home-manager switch --flake .#duckonomy@nixos

.PHONY: clean
clean:
	nix-collect-garbage -d

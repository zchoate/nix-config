{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {

  nixpkgs = {
    # You can add overlays here
    overlays = [
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  time.timeZone = "America/New_York";

  users.users = {
    zach = {
      # Be sure to change it (using passwd) after rebooting!
      initialHashedPassword = "$7$CU..../....dBH.RrxoCFDZJgu7xlaAh.$mlMEd3JWE15bT9JB3SkauKmM2clKzUSSFw6HUwUz/42";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCudWw3jiJI90peXnoxQV3IDdmXpHdxNVUb6R1bUK42G3sXs89hAv7h3v6cH0GSgFLqRflqwvqiFgXk0nGKAVAxE+zKS06kLgx0/Lidcf7VmQxXrJhEO5X5cLMyvUey7AuvBtSRgJrJy6BMJ8vp5oCctlme3tjxwK80SQ+5ZBJbG0v8eB6E3szsu6rVNGsIcOxUKLAU/HryZbZRMeT8us71xeccmecMEpnM93rS9bv4muf70uuhl2cxs3LllOIx9l1bpRp29NPilACenlKFpFiAvSs8vyJLbmm+uT8bLE93YPLh+iQPXgrSSOiMcdZ421mw5yrpoj0hPGGMUKFw5JXg5G5XzhpS2NcncGd8Zxknw+BNYb/KulWaItnPYG/bBmru8He8jCo8sxaYSrXCrOPLqVOFBwyp5Tl4qcqliAuXulcyDXH2NhLCNnLYlH0IQvxoOzJZZVDO8gawLXoE0I+OfAY5ZFdR4flbVmhTEQ5BJHdvYILxXlz/lbQ5c3697Ik="
      ];
      extraGroups = ["wheel"];
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

}
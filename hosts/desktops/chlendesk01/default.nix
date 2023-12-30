# # This is your system's configuration file.
# # Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
# {
#   inputs,
#   lib,
#   config,
#   pkgs,
#   ...
# }: {
#   # You can import other NixOS modules here
#   imports = [
#     # Import your generated (nixos-generate-config) hardware configuration
#     ./hardware-configuration.nix
#   ];

#   # Set the hostname
#   networking.hostName = "chlendesk01";

#   # Use the systemd-boot EFI boot loader.
#   boot.loader.systemd-boot.enable = true;
#   boot.loader.efi.canTouchEfiVariables = true;


#   networking.networkmanager.enable = true;

#   system.stateVersion = "23.11";
# }
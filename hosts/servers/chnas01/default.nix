# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  # Set the hostname
  networking.hostName = "chnas01";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.etc.crypttab = {
    enable = true;
    text = ''
      luks-nvme0n1 /dev/nvme0n1 /root/keyfile luks
      luks-nvme1n1 /dev/nvme1n1 /root/keyfile luks
    '';
  };

  fileSystems."/data/data-00" = { 
    device = "/dev/disk/by-uuid/90753f73-5f8f-4a9a-8a67-d9922099e95e";
    fsType = "btrfs";
    options = ["compress=zstd" "noatime"];
    depends = ["/dev/mapper/luks-nvme0n1"];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
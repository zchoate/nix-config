{
  pkgs,
  ...
}: {

  environment.systemPackages = with pkgs; [
    git
    jq
    wget
    # For LUKS setup
    cryptsetup
    # btrfs tools
    btrfs-progs
  ];

}
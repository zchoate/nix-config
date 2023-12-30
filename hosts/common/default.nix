{
  pkgs,
  ...
}: {

  environment.systemPackages = with pkgs; [
    git
    jq
    wget
  ];

}
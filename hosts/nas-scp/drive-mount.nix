{ config, ... }:
{
  fileSystems."/" = {
    options = [ "subvol=root" "noatime" "compress=zstd:3" "ssd" "space_cache=v2"];
  };

  fileSystems."/home" = {
    options = [ "subvol=home" "noatime" "compress=zstd:3" "ssd" "space_cache=v2"];
  };

  fileSystems."/nix" = {
    options = [ "subvol=nix" "noatime" "compress=zstd:3" "ssd" "space_cache=v2"];
  };

  fileSystems."/mnt/ssd" = {
    options = [ "noatime" "compress=zstd:3" "ssd" "space_cache=v2"];
  };

  fileSystems."/mnt/hdd" = {
    options = [ "noatime" "compress=zstd:3" "space_cache=v2"];
  };

  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "zstd";
    memoryPercent = 35;
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    # fileSystems = [ "/" ];
  };

  services.fstrim.enable = true;
}

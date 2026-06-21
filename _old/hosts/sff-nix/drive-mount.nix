{ config, ... }:
{
  fileSystems."/" = {
    options = [ "subvol=@root" "noatime" "compress=zstd:3" "ssd" "space_cache=v2" "autodefrag"];
  };

  fileSystems."/home" = {
    options = [ "subvol=@home" "noatime" "compress=zstd:3" "ssd" "space_cache=v2" "autodefrag"];
  };

  fileSystems."/nix" = {
    options = [ "subvol=@nix" "noatime" "compress=zstd:3" "ssd" "space_cache=v2" "autodefrag"];
  };

  fileSystems."/mnt/dados" = {
    device = "/dev/disk/by-uuid/145a3fdb-0b59-4001-80f5-1839494583c0";
    fsType = "btrfs";
    options = [ "subvol=@dados" "nofail" "noatime" "compress=zstd:3" "ssd" "space_cache=v2" "autodefrag" ];
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/145a3fdb-0b59-4001-80f5-1839494583c0";
    fsType = "btrfs";
    options = [ "subvol=@games" "nofail" "noatime" "compress=zstd:3" "ssd" "space_cache=v2" "autodefrag" ];
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
    fileSystems = [ "/" ];
  };

  services.fstrim.enable = true;
}
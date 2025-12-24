{ config, ... }:
{
  fileSystems."/" =
    { 
      options = ["noatime" "compress=zstd:3" "ssd" "discard=async" "space_cache=v2" "autodefrag"];
    };

  fileSystems."/home" =
    { 
      options = ["noatime" "compress=zstd:3" "ssd" "discard=async" "space_cache=v2" "autodefrag"];
    };

  fileSystems."/nix" =
    { 
      options = ["noatime" "compress=zstd:3" "ssd" "discard=async" "space_cache=v2" "autodefrag"];
    };

  fileSystems."/mnt/dados" =
    { 
      device = "/dev/disk/by-uuid/590733a9-e41b-45f0-9d7a-5ff65d0bc420";
      fsType = "btrfs";
      options = [ "nofail" "noatime" "compress=zstd:3" "ssd" "discard=async" "space_cache=v2" "autodefrag" ];
    };
  
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "zstd";
    memoryPercent = 30;
  };
}
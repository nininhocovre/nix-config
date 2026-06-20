{
  flake.modules.nixos.nas-scp = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [

    ];
  };
}

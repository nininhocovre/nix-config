{
  flake.modules.nixos.nh =
    { config, pkgs, ... }:
    {
      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep-since 30d --keep 30";
        };
        flake = "/home/nininho/nix-config";
      };

      # environment.systemPackages = with pkgs; [
      #   nix-output-monitor
      #   nvd
      # ];
    };
}

{
  flake.modules.nixos.nh =

  { config , pkgs, ... }:
  let
    username = config.hostVariables.username;
  in
  {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 30d --keep 30";
      };
      flake = "/home/${username}/nix-config";
    };

    # environment.systemPackages = with pkgs; [
    #   nix-output-monitor
    #   nvd
    # ];
  };
}
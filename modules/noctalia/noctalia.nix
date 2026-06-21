{ inputs, ... }:
{
  # flake.modules.nixos.noctalia = {
  #   home-manager.sharedModules = [ inputs.self.modules.homeManager.noctalia ];
  # };

  flake.modules.homeManager.noctalia =
    { config, pkgs, ... }:
    let
      filePath = "/home/nininho/nix-config/modules/desktop/hyprland/programs/noctalia/files";
      configSrc = config.lib.file.mkOutOfStoreSymlink filePath;
    in
    {
      home.packages = with pkgs; [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      xdg.configFile."noctalia".source = configSrc;
    };
}

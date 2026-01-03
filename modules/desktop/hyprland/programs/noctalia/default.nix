{ config, pkgs, inputs, ... }:
{
  home-manager.sharedModules = [
  (
    { config, ... }: 
    let
      filePath = "/home/nininho/nix-config/modules/desktop/hyprland/programs/noctalia/files";
      configSrc = config.lib.file.mkOutOfStoreSymlink filePath;
    in
    {
      home.packages = with pkgs; [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      xdg.configFile."noctalia".source = configSrc;
    })
  ];
}
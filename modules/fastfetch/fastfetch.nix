{ inputs, ...}:
{
  flake.modules.nixos.fastfetch = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.fastfetch ];
  };

  flake.modules.homeManager.fastfetch = {
    programs.fastfetch = {
      enable = true;
    };
    xdg.configFile = {
      "fastfetch/config.jsonc".source = ./config.jsonc;
      "fastfetch/icons" = {
        source = ./icons;
        recursive = true;
      };
    };
  };
}

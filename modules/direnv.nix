{ inputs, ...}:
{
  flake.modules.nixos.direnv = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.direnv ];
    environment.variables."DIRENV_WARN_TIMEOUT" = "60s";
  };

  flake.modules.homeManager.direnv = {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = false;
      enableNushellIntegration = false;
    };
    # home.sessionVariables = {
    #   # DIRENV_DIR = "/tmp/direnv";
    #   # DIRENV_CACHE = "/tmp/direnv-cache"; # Optional, for caching
    # };
  };
}

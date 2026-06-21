{ inputs, ...}:
{
  flake.modules.nixos.nixvim = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.nixvim ];
  };

  flake.modules.homeManager.nixvim = 
  {
    pkgs,
    ...
  }:
  let
    terminal = "kitty";
  in
  {
    home.packages = with pkgs; [
      inputs.nixvim.packages.${stdenv.hostPlatform.system}.default
    ];
    xdg.desktopEntries = {
      "nvim" = {
        name = "Neovim wrapper";
        genericName = "Text Editor";
        comment = "Edit text files";
        exec = "${pkgs.${terminal}}/bin/${terminal} --class \"nvim-wrapper\" -e nvim %F";
        icon = "nvim";
        mimeType = [
          "text/plain"
          "text/x-makefile"
        ];
        categories = [
          "Development"
          "TextEditor"
        ];
        terminal = false; # Important: set to false since we're calling kitty directly
      };
    };
  };
}

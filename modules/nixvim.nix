{ inputs, ... }:
{
  flake.modules.nixos.nixvim = {
    imports = [
      inputs.nixvim.nixosModules.nixvim
    ];

    programs.nixvim = {
      enable = true;

      defaultEditor = true;
      vimAlias = true;

      colorschemes.catppuccin = {
        enable = true;
        settings.flavour = "mocha";
      };
    };
  };
}

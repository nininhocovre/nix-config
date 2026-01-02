{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      
      nerd-fonts.jetbrains-mono
      roboto
      roboto-serif
      nerd-fonts.roboto-mono
      liberation_ttf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font"
          "Roboto Mono"
          "Noto Mono"
          "DejaVu Sans Mono" # Default
        ];
        sansSerif = [
          "Noto Sans"
          "DejaVu Sans" # Default
        ];
        serif = [
          "Noto Serif"
          "DejaVu Serif" # Default
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}

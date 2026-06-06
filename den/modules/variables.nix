{ lib, config, pkgs, ... }:
{
  options.hostVariables = {
    username = lib.mkOption { type = lib.types.str; };
    desktop = lib.mkOption { type = lib.types.str; };
    waybarTheme = lib.mkOption { type = lib.types.str; };
    sddmTheme = lib.mkOption { type = lib.types.str; };
    defaultWallpaper = lib.mkOption { type = lib.types.str; };
    hyprlockWallpaper = lib.mkOption { type = lib.types.str; };
    terminal = lib.mkOption { type = lib.types.str; };
    editor = lib.mkOption { type = lib.types.str; };
    browser = lib.mkOption { type = lib.types.str; };
    tuiFileManager = lib.mkOption { type = lib.types.str; };
    shell = lib.mkOption { type = lib.types.str; };
    games = lib.mkOption { type = lib.types.bool; };
    hostname = lib.mkOption { type = lib.types.str; };
    videoDriver = lib.mkOption { type = lib.types.str; };
    timezone = lib.mkOption { type = lib.types.str; };
    locale = lib.mkOption { type = lib.types.str; };
    clock24h = lib.mkOption { type = lib.types.bool; };
    kbdLayout = lib.mkOption { type = lib.types.str; };
    kbdVariant = lib.mkOption { type = lib.types.str; };
    consoleKeymap = lib.mkOption { type = lib.types.str; };
  };
}
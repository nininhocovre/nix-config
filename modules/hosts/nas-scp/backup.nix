{
  flake.modules.nixos.nas-scp = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      restic
      backrest
    ];

    systemd.services.backrest = {
      description = "Backrest service";
      wantedBy = [ "multi-user.target" ];
      requires = [ "network-online.target" ];
      script = "backrest";
      path = [ pkgs.backrest ];
      environment = {
        BACKREST_PORT = "0.0.0.0:9898";
      };
      serviceConfig = {
        Type = "simple";
        User = "root";
        Group = "root";
      };
    };

    networking.firewall.allowedTCPPorts = [ 9898 ];
  };
}

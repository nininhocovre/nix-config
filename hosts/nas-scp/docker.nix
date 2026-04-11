{ config, pkgs, ... }:
{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    oci-containers = {
      backend = "docker";
      
      containers = {
        arcane = {
          image = "ghcr.io/getarcaneapp/arcane:latest";
          ports = [ "3552:3552" ];
          volumes = [ 
            "/var/run/docker.sock:/var/run/docker.sock"
            "/home/nininho/docker/arcane:/app/data"
            "/home/nininho/docker/projects:/home/nininho/docker/projects"
          ];
          environment = {
            APP_URL = "http://localhost:3552";
            PUID = "1000";
            PGID = "100";
            PROJECTS_DIRECTORY = "/home/nininho/docker/projects";
            ENCRYPTION_KEY = "4790d75b02e050759d3a803f6826a5716a10b6bb1c320b2a54c8d8f5e1ca7d86";
            JWT_SECRET = "890a46bf69975f98a606bde13a553d0ba1b315a584fa7730f268c3d4321d17c5";
            LOG_LEVEL = "info";
            LOG_JSON = "false";
            OIDC_ENABLED = "false";
            DATABASE_URL = "file:data/arcane.db?_pragma=journal_mode(WAL)&_pragma=busy_timeout(2500)&_txlock=immediate";
          };
          extraOptions = [
            # "--restart=unless-stopped"
            "--net=compose-network"
          ];
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ ];
}

{ pkgs, ... }: {
  channel = "stable-23.11";
  
  packages = [
    pkgs.tailscale
  ];
  
  env = {};
  
  idx = {
    extensions = [
      "tailscale.vscode-tailscale"
    ];
    workspace = {
      onCreate = {};
      onStart = {};
    };
    
  };

  services.docker.enable = true;
  services.tailscale.enable = true;
}

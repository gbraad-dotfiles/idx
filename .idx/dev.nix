{ pkgs, ... }: {
  channel = "stable-23.11";
  
  packages = [
    pkgs.tailscale
  ];
  
  env = {};
  
  idx = {
    extensions = [
      "ms-vscode.Theme-TomorrowKit"
      "tailscale.vscode-tailscale"
    ];
    workspace = {
      onCreate = {};
      onStart = {};
    };
    
  };

  services = {
    docker.enable = true;
    #tailscale.enable = true;
  };
}

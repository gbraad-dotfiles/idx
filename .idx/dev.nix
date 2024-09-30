{ pkgs, ... }: {
  channel = "stable-24.05";
  
 packages = [
    pkgs.stow
    pkgs.screen
    pkgs.tmux
    pkgs.zsh
    pkgs.powerline
    pkgs.podman
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

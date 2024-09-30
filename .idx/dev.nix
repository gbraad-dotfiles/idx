{ pkgs, ... }: {
  channel = "stable-24.05";
  
  packages = [
    pkgs.tailscale
    pkgs.screen
    pkgs.tmux
    pkgs.zsh
    pkgs.powerline
    pkgs.podman
    pkgs.stow
    pkgs.openssh
  ];
  
  env = {
    
  };
  
  idx = {
    extensions = [
      "ms-vscode.Theme-TomorrowKit"
      "tailscale.vscode-tailscale"
    ];
    workspace = {
      onCreate = {
        setup-podman = ''
          
        '';
        install-dotfiles = ''
          git clone https://github.com/gbraad/dotfiles /tmp/dotfiles
          /tmp/dotfiles/install.sh
        '';
      };
      onStart = {
        start-tailscale = "screen tailscaled --tun='userspace-networking'";
        default.openFiles = [];
      };
    };
    
  };

  services = {
    docker.enable = true;
    #tailscale.enable = true;
    #tailscale.interfaceName = "userspace-networking";
  };
}

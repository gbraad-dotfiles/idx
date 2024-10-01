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
        setup-hostname = ''
          cat >> /etc/hostname <<EOF
          idx-devenv
          EOF
        '';
        # this is to fix Podman: https://github.com/gbraad-devenv/idx/issues/3
        setup-podman = ''
          mkdir /etc/containers/
          cat >> /etc/containers/policy.json <<EOF
          { "default" : [ { "type": "insecureAcceptAnything"} ]}
          EOF
          mkdir /var/tmp
        '';
        install-dotfiles = ''
          git clone https://github.com/gbraad/dotfiles /tmp/dotfiles
          /tmp/dotfiles/install.sh
        '';
      };
      onStart = {
        start-tailscale = ''
          screen -d -m tailscaled \
            --tun="userspace-networking" \
            --socket=/var/run/tailscale/tailscaled.sock
        '';
        default.openFiles = [];
      };
    };
    
  };

  services = {
    docker.enable = true;

    # this does not work on IDX
    #tailscale.enable = true;
    #tailscale.interfaceName = "userspace-networking";
  };
}

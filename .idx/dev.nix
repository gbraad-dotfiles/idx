{ pkgs, ... }: {
  channel = "stable-24.05";
  
  packages = [
    pkgs.git
    pkgs.tailscale
    pkgs.screen
    pkgs.tmux
    pkgs.zsh
    pkgs.powerline
    pkgs.podman
    pkgs.stow
    pkgs.openssh
    pkgs.cadaver
  ];
  
  env = {
    
  };
  
  idx = {
    extensions = [
      "ms-vscode.Theme-TomorrowKit"
      "tailscale.vscode-tailscale"
      "gbraad.analogue-clock"
      "gbraad.dotfiles-checker"
      "gbraad.dotfiles-tools"
    ];
    workspace = {
      onCreate = {
        setup-hostname = ''
          cat >> /etc/hostname <<EOF
          idx-workspace
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
        start-code-tunnel = ''
          screen -d -m ~/.local/bin/code tunnel \
             --accept-server-license-terms \
             --name idx-workspace
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

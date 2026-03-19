{ config, pkgs, inputs, ... }:

{
  home.username = "Jan";
  home.homeDirectory = "/home/Jan";
  home.stateVersion = "25.11";

  # Git
  programs.git = {
    enable = true;
    userName = "Jan Trygve Kaasen";
    userEmail = "jtkaasen@gmail.com";
  };

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

home.packages = with pkgs; [
    ghostty
    inputs.zen-browser.packages."${pkgs.system}".default
        # Java
    jdk

    # Rust
    rustup

    # C
    gcc
    gnumake
    cmake
    gdb

    # Python
    python3
    python3Packages.pip

    # Haskell
    ghcup
    stack
    cabal-install
    hoogle
    ormolu

    # Dev tools
    ripgrep
    fd
    fzf
    unzip
    docker-compose

    # Apps
    discord
    spotify
];

  # Link your existing dotfiles
  # Adjust paths to match what's in your repo
home.file = {
    ".config".source = ./dotfiles/.config;
    ".tmux.conf".source = ./dotfiles/.tmux.conf;
    ".zshrc".source = ./dotfiles/.zshrc;
    ".config/wallpaper.jpg".source = ./dotfiles/1379845.jpg;
  };

  programs.home-manager.enable = true;
}
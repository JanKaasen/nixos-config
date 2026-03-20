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
    plugins = with pkgs.vimPlugins; [
    ];
  };

home.packages = with pkgs; [
    ghostty
    inputs.zen-browser.packages."${pkgs.system}".default
    # Java
    jdk25
    maven

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

    # Dev tools
    ripgrep
    fd
    fzf
    unzip
    docker-compose

    # Apps
    discord
    spotify

    starship
    tmux
    lazygit

    lua5_1
        lua51Packages.luarocks

    fastfetch
    
    waybar
    wofi
    nerd-fonts.jetbrains-mono
    nodejs
    hyprshot
];

  # Link your existing dotfiles
  # Adjust paths to match what's in your repo
home.file = {
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/Jan/.config/nixos/dotfiles/.config/hypr";
    ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "/home/Jan/.config/nixos/dotfiles/.config/ghostty";
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "/home/Jan/.config/nixos/dotfiles/.config/waybar";
    ".config/wofi".source = config.lib.file.mkOutOfStoreSymlink "/home/Jan/.config/nixos/dotfiles/.config/wofi";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/Jan/.config/nixos/dotfiles/.config/nvim";
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/Jan/.config/nixos/dotfiles/.tmux.conf";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/Jan/.config/nixos/dotfiles/.zshrc";
  };

  programs.home-manager.enable = true;
}

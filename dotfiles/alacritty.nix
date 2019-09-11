{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      tabspaces = 2;
      font = {
        normal = {
          family = "Source Code Pro";
          style = "Regular";
        };
        bold = {
          family = "Source Code Pro";
          style = "Bold";
        };
        italic = {
          family = "Source Code Pro";
          style = "Italic";
        };
        bold-italic = {
          family = "Source Code Pro";
          style = "Bold Italic";
        };
        size = 10;
      };
      colors = {
        primary = {
          background = "#282a36";
          foreground = "#f8f8f2";
        };
        cursor = {
          cursor = "#81c1e4";
        };
        selection = {
          background = "#ccccc7";
        };
        normal = {
          black =   "#000000";
          red =     "#ff5555";
          green =   "#50fa7b";
          yellow =  "#f1fa8c";
          blue =    "#caa9fa";
          magenta = "#ff79c6";
          cyan =    "#8be9fd";
          white =   "#bfbfbf";
        };
        bright = {
          black =   "#575b70";
          red =     "#ff6e67";
          green =   "#5af78e";
          yellow =  "#f4f99d";
          blue =    "#caa9fa";
          magenta = "#ff92d0";
          cyan =    "#9aedfe";
          white =   "#e6e6e6";
        };
      };
      background_opacity = 0.8;
      mouse.url.launcher = "firefox";
    };
  };
}

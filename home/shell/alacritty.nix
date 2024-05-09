let
  font = "Hack";
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      env.WINIT_X11_SCALE_FACTOR = "1.0";

      # window.opacity = 0.95;
      # window.dynamic_padding = true;
      # window.padding = { x = 5; y = 5; };
      font = {
        size = 10.0;
        normal.family = font;
        bold.family = font;
        italic.family = font;
        bold_italic.family = font;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
}

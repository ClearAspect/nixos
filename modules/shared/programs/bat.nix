{
  config,
  pkgs,
  ...
}: {
  bat = {
    enable = true;
    # catppuccin.enable = true;
    config = {
      theme = "OneHalfDark";
    };
  };
}

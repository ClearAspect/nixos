{
  config,
  pkgs,
  inputs,
  ...
}: {
  anyrun = {
    enable = true;
    config = {
      x = {fraction = 0.5;};
      y = {fraction = 0.3;};
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = false;
      showResultsImmediately = true;
      maxEntries = null;

      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
      ];
    };

    extraCss = ''
      /* GTK Vars */
      @define-color bg-color #282c34;
      @define-color fg-color #dcdfe4;
      @define-color primary-color #61afef;
      @define-color secondary-color #56b6c2;
      @define-color border-color @primary-color;
      @define-color selected-bg-color @primary-color;
      @define-color selected-fg-color @bg-color;

      * {
        all: unset;
        font-family: SF Pro Display;
      }

      #window {
        background: transparent;
      }

      box#main {
        border-radius: 16px;
        background-color: alpha(@bg-color, 0.6);
        border: 0.5px solid alpha(@fg-color, 0.25);
      }

      entry#entry {
        font-size: 1.25rem;
        background: transparent;
        box-shadow: none;
        border: none;
        border-radius: 16px;
        padding: 16px 24px;
        min-height: 40px;
        caret-color: @primary-color;
      }

      list#main {
        background-color: transparent;
      }

      #plugin {
        background-color: transparent;
        padding-bottom: 4px;
      }

      #match {
        font-size: 1.1rem;
        padding: 2px 4px;
      }

      #match:selected,
      #match:hover {
        background-color: @selected-bg-color;
        color: @selected-fg-color;
      }

      #match:selected label#info,
      #match:hover label#info {
        color: @selected-fg-color;
      }

      #match:selected label#match-desc,
      #match:hover label#match-desc {
        color: alpha(@selected-fg-color, 0.9);
      }

      #match label#info {
        color: transparent;
        color: @fg-color;
      }

      label#match-desc {
        font-size: 1rem;
        color: @fg-color;
      }

      label#plugin {
        font-size: 16px;
      }
    '';
  };
}

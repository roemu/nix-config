{
  config,
  lib,
  ...
}: let
  cfg = config.features.desktop.zen-browser;
in {
  options.features.desktop.zen-browser.enable = lib.mkEnableOption "Enable extended zen-browser configuration";

  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      # profiles.default = {
      #   mods = [
      #     "a6335949-4465-4b71-926c-4a52d34bc9c0"
      #   ];
      #   search = {
      #     force = true;
      #     default = "ddg";
      #   };
      #   isDefault = true;
      #   containersForce = true;
      #   containers = {
      #     Personal = {
      #       color = "purple";
      #       icon = "fingerprint";
      #       id = 1;
      #     };
      #     Work = {
      #       color = "blue";
      #       icon = "briefcase";
      #       id = 2;
      #     };
      #   };
      #   spacesForce = true;
      #   spaces = let
      #     containers = config.programs.zen-browser.profiles."default".containers;
      #   in {
      #     "work" = {
      #       id = "cdd10fab-4fc5-494b-9041-325e5759195b";
      #       icon = "W";
      #       container = containers."Work".id;
      #       position = 1000;
      #     };
      #     "personal" = {
      #       id = "4ad11a75-9e33-465c-88aa-ec2565d61f6e";
      #       icon = "P";
      #       container = containers."Personal".id;
      #       position = 2000;
      #     };
      #   };
      #   settings = {
      #     "browser.tabs.warnOnClose" = false;
      #     "browser.aboutConfig.showWarning" = false;
      #     "browser.tabs.unloadOnLowMemory" = true;
      #     "browser.urlbar.suggest.calculator" = true;
      #     "browser.urlbar.unitConversion.enabled" = true;
      #     "findbar.highlightAll" = true;
      #     "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

      #     # disable fullscreen notification
      #     "full-screen-api.transition-duration.enter" = "0 0";
      #     "full-screen-api.transition-duration.leave" = "0 0";
      #     "full-screen-api.warning.delay" = -1;
      #     "full-screen-api.warning.timeout" = 0;

      #     # ZEN SPECIFICS
      #     "zen.folders.owned-tabs-in-folder" = true;
      #     "zen.view.experimental-force-window-controls-left" = true;
      #     "zen.view.show-newtab-button-top" = false;
      #     "browser.ctrlTab.sortByRecentlyUsed" = true;
      #     "browser.tabs.hoverPreview.enabled" = true;
      #   };
      # };
    };
  };
}

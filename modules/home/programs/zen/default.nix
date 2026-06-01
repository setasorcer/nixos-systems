{ inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = let
  mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
    installation_mode = "force_installed";
  });
  in {
    enable = true;
    setAsDefaultBrowser = true;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      ExtensionSettings = mkExtensionSettings {
        "uBlock0@raymondhill.net" = "ublock-origin";
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = "violentmonkey";
        "{cb31ec5d-c49a-4e5a-b240-16c767444f62}" = "indie-wiki-buddy";
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
        "{6b733b82-9261-47ee-a595-2dda294a4d08}" = "yomitan";
      };
    };
    profiles.default = {
      search = {
        force = true;
        default = "ddg";
        engines = {
          youtube = {
            name = "YouTube";
            urls = [
              {
                template = "https://www.youtube.com/results?search_query={searchTerms}";
              }
            ];
            definedAliases = ["@yt"];
          };
        };
      };
      mods = [
        "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
        "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
      ];
      containersForce = true;
      containers = {
        Personal = {
          color = "purple";
          icon = "fingerprint";
          id = 1;
        };
        Business = {
          color = "yellow";
          icon = "dollar";
          id = 3;
        };
        Work = {
          color = "blue";
          icon = "briefcase";
          id = 2;
        };
      };
      spacesForce = true;
      spaces = {
        "Personal" = {
          id = "b11920f0-862f-4a14-87cc-4acb2ae879bc";
          position = 1000;
          icon = "chrome://browser/skin/zen-icons/selectable/bed.svg";
        };
        "Business" = {
          id = "ba4f1b7f-1853-4f4d-b37e-2e6ec9977bdb";
          position = 2000;
          icon = "chrome://browser/skin/zen-icons/selectable/logo-usd.svg";
          container = 3;
        };
        "Work" = {
          id = "396f8dc7-2cf1-4746-b35c-7d67261caef0";
          position = 3000;
          icon = "chrome://browser/skin/zen-icons/selectable/briefcase.svg";
          container = 2;
        };
      };
    };
  };
}

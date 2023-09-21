{ config, pkgs, ... }:
{
    programs.firefox = {
        enable = true;
        package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
            CaptivePortal = false;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DisableFirefoxAccounts = false;
            NoDefaultBookmarks = true;
            OfferToSaveLogins = false;
            OfferToSaveLoginsDefault = false;
            PasswordManagerEnabled = false;
            FirefoxHome = {
            Search = true;
            Pocket = false;
            Snippets = false;
            TopSites = false;
            Highlights = false;
            };
            UserMessaging = {
            ExtensionRecommendations = false;
            SkipOnboarding = true;
            };
        };
        };
        profiles.default = {
        id = 0;
        name = "Default";
        # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        #     ublock-origin
        # ];
        search = {
            force = true;
            default = "DuckDuckGo";
            engines = {
            "Nix Packages" = {
                urls = [{
                    template = "https://search.nixos.org/packages";
                    params = [
                        { name = "type"; value = "packages"; }
                        { name = "query"; value = "{searchTerms}"; }
                    ];
                }];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
            };
            "Wikipedia (en)".metaData.alias = "@wiki";
            "Google".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
            };
        };
        settings = {
            "general.smoothScroll" = true;
        };
        };
    };
}
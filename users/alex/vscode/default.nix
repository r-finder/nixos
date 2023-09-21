{ config, pkgs, ... }:
{
    programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        extensions = with pkgs.vscode-extensions; [
            #dracula-theme.theme-dracula
            #vscodevim.vim
            yzhang.markdown-all-in-one
            jnoortheen.nix-ide
        ];
        userSettings = {
            "workbench.startupEditor" = "none";
            "git.enableSmartCommit" = true;
            "update.mode" = "none";
            "git.confirmSync" = false;
            "window.titleBarStyle" = "custom";
            "explorer.confirmDelete" = false;
            "[nix]"."editor.tabSize" = 2;
        };
    };
}

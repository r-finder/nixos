{ config, pkgs, ... }:
{
	xdg = {
		configFile."kanshi/config".source = ./kanshi;
	};

   	wayland.windowManager.sway = {
    enable = true;
    extraConfig = builtins.readFile ./extraConfig;

    config = rec {
      modifier = "Mod4";      
      terminal = "alacritty"; 
      window.border = 1;
	  window.titlebar = false;
      menu = "bmenu";
		bars = [
			{
				position = "top";
				command = "waybar";
			}
		];

		keybindings = let 
			volumeup = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
			volumedown = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-";
			mute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
		in
		{
			# https://wiki.linuxquestions.org/wiki/List_of_Keysyms_Recognised_by_Xmodmap
			"${modifier}+Return" = "exec ${terminal}";
			"${modifier}+p" = "exec ${menu}";
			"${modifier}+Shift+f" = "exec firefox";
			"${modifier}+Shift+o" = "exec obsidian";
			"${modifier}+Shift+c" = "exec codium";

			"${modifier}+Shift+q" = "kill";

			# "${modifier}+${up}" = "focus up";
			# "${modifier}+${down}" = "focus down";
			# "${modifier}+${left}" = "focus left";
			# "${modifier}+${right}" = "focus right";
		
			"${modifier}+Up" = "focus up";
			"${modifier}+Down" = "focus down";
			"${modifier}+Left" = "focus left";
			"${modifier}+Right" = "focus right";
		
			# "${modifier}+Shift+${up}" = "move up";
			# "${modifier}+Shift+${down}" = "move down";
			# "${modifier}+Shift+${left}" = "move left";
			# "${modifier}+Shift+${right}" = "move right";
		
			"${modifier}+Shift+Up" = "move up";
			"${modifier}+Shift+Down" = "move down";
			"${modifier}+Shift+Left" = "move left";
			"${modifier}+Shift+Right" = "move right";

			"${modifier}+b" = "splith";
			"${modifier}+v" = "splitv";

			"${modifier}+1" = "workspace number 1";
			"${modifier}+2" = "workspace number 2";
			"${modifier}+3" = "workspace number 3";
			"${modifier}+4" = "workspace number 4";
			"${modifier}+5" = "workspace number 5";
			"${modifier}+6" = "workspace number 6";
			"${modifier}+7" = "workspace number 7";
			"${modifier}+8" = "workspace number 8";
			"${modifier}+9" = "workspace number 9";
			"${modifier}+0" = "workspace number 10";
		
			"${modifier}+Shift+1" = "move container to workspace number 1";
			"${modifier}+Shift+2" = "move container to workspace number 2";
			"${modifier}+Shift+3" = "move container to workspace number 3";
			"${modifier}+Shift+4" = "move container to workspace number 4";
			"${modifier}+Shift+5" = "move container to workspace number 5";
			"${modifier}+Shift+6" = "move container to workspace number 6";
			"${modifier}+Shift+7" = "move container to workspace number 7";
			"${modifier}+Shift+8" = "move container to workspace number 8";
			"${modifier}+Shift+9" = "move container to workspace number 9";
			"${modifier}+Shift+0" = "move container to workspace number 10";

			# "Ctrl+${modifier}+Left" = "workspace prev";
			# "Ctrl+${modifier}+Right" = "workspace next";

			# "Ctrl+${modifier}+${left}" = "workspace prev";
			# "Ctrl+${modifier}+${right}" = "workspace next";

			"${modifier}+Shift+Space" = "floating toggle";
			"${modifier}+Space" = "focus_mode toggle";
			"${modifier}+f" = "fullscreen toggle";
			"${modifier}+n" = "exec flashfocus";
			"XF86AudioRaiseVolume" = "exec ${volumeup}";
			"XF86AudioLowerVolume" = "exec ${volumedown}";
			"${modifier}+Page_Up" = "exec ${volumeup}";
			"${modifier}+Page_Down" = "exec ${volumedown}";
			"XF86AudioMute" = "exec ${mute}";
			"XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
			"XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
			"Print" = "exec grim - | wl-copy";
			"${modifier}+Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
		};

		startup = [
			{command = "firefox";}
			{command = "kanshi";}
		];
    };
  };
}

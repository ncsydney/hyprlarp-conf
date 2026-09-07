# Commands to run in interactive sessions can go here
	starship init fish | source
if test -z "$DISPLAY"
    if test (tty) = "/dev/tty1"
        exec start-hyprland
    end
end

abbr ff 'fastfetch'

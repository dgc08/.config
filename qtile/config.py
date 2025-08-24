# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Copyright (c) 2024 Sinthoras39 (This is my config; I modified the qtile default config)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, qtile, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from libqtile import hook

from os.path import expanduser
from os import system
from datetime import datetime
from time import sleep

mod = "mod4"
office = [mod, "shift", "control", "mod1"] #stupid office key from microsoft keyboard
terminal = "alacritty"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.normalize()),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "BackSpace", lazy.spawn(expanduser('~/.config/qtile/rofi.sh')), desc="Rofi application launcher"),
    Key([], "Print", lazy.spawn('flameshot gui'), desc="take screenshot"),
    Key([*office], "space", lazy.spawn(expanduser('~/.config/qtile/layout.sh')), desc="Switch layouts"),
    #Key([], "mod4", lazy.spawn('./layout.sh'), desc="Switch layouts"),
    #

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod], "z", lazy.spawn("setxkbmap -option")),
    Key([mod, "control"], "z", lazy.spawn("setxkbmap -option caps:swapescape")),

    Key([mod], "q", lazy.spawn("emacsclient -c"), desc="Texteditor"),
    Key([mod], "e", lazy.spawn("emacsclient --eval \"(emacs-everywhere)\" --frame-parameters '((name . \"Emacs Everywhere\"))'")),

    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod], "b", lazy.hide_show_bar(), desc="Hides the bar"),

    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),

    Key([mod], "p", lazy.spawn("i3lock --color #FF6F00"), desc="Lock screen"),
    Key([mod, "control"], "p", lazy.shutdown(), desc="Log out/Shutdown Qtile"),

    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),


    # Keyboard shortcuts for media
    Key([mod], "y", lazy.spawn("playerctl previous"), desc="Previous media"),
    Key([mod, "control"], "y", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -1%"), desc="Dec volume"),
    Key([mod], "x", lazy.spawn("playerctl play-pause"), desc="Play/Pause"),
    Key([mod], "c", lazy.spawn("playerctl next"), desc="Next media"),
    Key([mod, "control"], "c", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +1%"), desc="Inc volume"),

    # Media keys
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Previous media"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -1%"), desc="Dec volume"),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Play/Pause"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Next media"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +1%"), desc="Inc volume"),
    Key([], "XF86Tools", lazy.spawn("pavucontrol"), desc="Volume control"),

    Key([], "XF86Calculator", lazy.spawn("speedcrunch"), desc="calcutor"),

    Key([mod], "k", lazy.spawn("killall python3 -9"), desc="calcutor"),

    Key([mod], "r", lazy.spawn("flatpak run it.mijorus.smile"), desc="emoji"),
]

    # Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "123asduio"]

for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            # Key(
            #     [mod, "shift"],
            #     i.name,
            #     lazy.window.togroup(i.name, switch_group=True),
            #     desc="Switch to & move focused window to group {}".format(i.name),
            # ),
            # Or, use below if you prefer not to switch to that group.
            # mod1 + shift + group number = move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                 desc="move focused window to group {}".format(i.name)),
        ]
    )

@hook.subscribe.startup_once
def autostart():
    from subprocess import Popen

    Popen([expanduser('~/.config/qtile/autostart.sh')])
    #system(expanduser("~/.nix-profile/bin/nitrogen --set-zoom ~/.config/qtile/wallpapers/wallpaper.png"))

    # if 6 <= datetime.now().hour < 11:
    #    Popen(["notify-send", "System kann vor 11 Uhr nicht verwendet werden", "Es ist noch vor 11:00. Sie werden in Kürze abgemeldet."])
    #    sleep(10)
    #    qtile.shutdown()

    Popen([expanduser('~/.config/qtile/autostart_post.sh')])

layouts = [
    layout.Columns(num_colums = 3, grow_amount = 5, border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=2, initial_ratio=1.5),
    #layout.Bsp(fair = False, grow_amount = 5), # I love bsp
    layout.Max(),
    #layout.Tile(border_on_single=False, border_width=1),
    #layout.MonadTall(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.TreeTab(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=4),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Ubuntu",
    fontsize=13,
    padding=3,
)
extension_defaults = widget_defaults.copy()

from widgets import widgets
screens = [
    Screen(
        top=bar.Bar(
            widgets,
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        bottom=bar.Bar(
            [
                widget.GroupBox(),
                # widget.TextBox(" || "),
                widget.Prompt(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(title="emacs-everywhere"),
        Match(title="Smile"),
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

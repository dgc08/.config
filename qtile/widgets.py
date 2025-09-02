#!/usr/bin/env python
import os
from libqtile import bar, widget
from libqtile.lazy import lazy
from libqtile.config import Screen

from datetime import datetime

from colors import *

current_hour = datetime.now().hour

# Determine the appropriate greeting based on the current hour
if 5 <= current_hour < 12:
    day_text = "Hallo und Guten Morgen"
elif 12 <= current_hour < 18:
    day_text = "Hallo und Guten Tag"
elif current_hour < 5 or current_hour > 22:
    day_text = "Geh schlafen"
elif 5 <= current_hour < 10:
    day_text = "So früh wach?"
else:
    day_text = "Hallo und Guten Abend"

widget_defaults = dict(
    font=DEFAULT_FONT,
    background=color_schema['bg'],
    foreground=color_schema['fg'],
    fontsize=14,
    padding=10,
)
extension_defaults = widget_defaults.copy()

separator = widget.Sep(padding=10, size_percent=50, foreground=color_schema['fg3'])
widgets = [
    widget.GroupBox(
        disable_drag=True,
        use_mouse_wheel=False,
        active=color_schema['fg'],
        inactive=color_schema['dark-gray'],
        highlight_method='text',
        this_current_screen_border=color_schema['dark-yellow'],
        urgent_alert_method='text',
        urgent_text=color_schema['dark-red'],
        fontsize=18,
        padding=1,
    ),

    separator,
    widget.WindowName(),
    widget.Spacer(),
    widget.Clock(format='%d %b %H:%M:%S'),
    widget.Spacer(),
    widget.Systray(),
    # widget.Chord(
    #     chords_colors={
    #         "launch": ("#ff0000", "#ffffff"),
    #     },
    #     name_transform=lambda name: name.upper(),
    # ),
    widget.TextBox("  " + day_text, foreground="#31cccc"),
    separator,
    widget.Memory(
        mouse_callbacks={'Button1': lambda qtile: qtile.cmd_spawn(
            self.termite + ' -e htop')},
        padding=5
    ),
    separator,
    widget.PulseVolume(
        padding=5,
        mouse_callbacks={'Button1': lazy.spawn("pavucontrol")},
        fmt='󰕾   {}',
    ),
    separator,
    widget.Net(
        interface="enp4s0",
        mouse_callbacks={'Button1': lazy.spawn("nm-connection-editor")},
    ),
    separator,
    widget.KeyboardLayout(
        configured_keyboards=["kakutr", "engvi", "ru phonetic"],
        display_map={"kakutr": "kakutro", "vi": "multitro", "ru phonetic": "russian"},  # Optional display customization
        fmt='󰌌   {}',
    ),
    separator,
    widget.CurrentLayout(),
]

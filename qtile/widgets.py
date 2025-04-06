#!/usr/bin/env python
import os
from libqtile import bar, widget
from libqtile.lazy import lazy
from libqtile.config import Screen

from datetime import datetime

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


widgets = [
    widget.CurrentLayout(
        padding=5
    ),
    widget.TextBox(" |  Layout: "),
    widget.KeyboardLayout(
        configured_keyboards=["kakutr", "engvi", "ru phonetic"],  # Add layouts you want to toggle
        display_map={"kakutr": "kakutropos", "vi": "multitropos", "ru phonetic": "russian"},  # Optional display customization
        padding=5
    ),
    widget.TextBox(" | "),
    widget.WindowName(),
    widget.Systray(),
    # widget.Chord(
    #     chords_colors={
    #         "launch": ("#ff0000", "#ffffff"),
    #     },
    #     name_transform=lambda name: name.upper(),
    # ),
    widget.TextBox("  " + day_text, foreground="#31cccc"),
    widget.TextBox(" | "),

    widget.Memory(
        mouse_callbacks={'Button1': lambda qtile: qtile.cmd_spawn(
            self.termite + ' -e htop')},
        padding=5
    ),
    widget.TextBox(" | "),
    widget.TextBox(
        text="  ",
        padding=0,
        mouse_callbacks={'Button1': lazy.spawn("pavucontrol")},
    ),
    widget.PulseVolume(
        padding=5,
        mouse_callbacks={'Button1': lazy.spawn("pavucontrol")},
    ),
    widget.TextBox(" | "),
    widget.Net(
        interface="enp4s0",
        mouse_callbacks={'Button1': lazy.spawn("nm-connection-editor")},
    ),
    widget.TextBox(" | "),
    widget.Clock(
        format="%B %d  [ %H:%M:%S ]"
    )
]

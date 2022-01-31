#!/usr/bin/env python
import os
import sys


def is_tool(name):
    """Check whether `name` is on PATH and marked as executable."""

    from shutil import which

    return which(name) is not None


REQUIRED_EXEC = ["rofi", "flameshot"]
for exec in REQUIRED_EXEC:
    if not is_tool(exec):
        print(f"{exec} not found")
        sys.exit(0)

ROFI_THEME = "utility"
# Rofi uses "\n" to seperate item display
# E.g: "a\nb\nc" results in 3 items in rofi menu
ROFI_COMMAND = f"rofi -theme {ROFI_THEME} -dmenu -format i -i -p"

# I can do OOP, but nah...
COMMANDS = [
    {
        "display": "Screenshot",
        "prompt": "麗",
        "action": [
            {
                "display": "Screen",
                "action": 'flameshot screen -p "$HOME/Pictures/"',
            },
            {
                "display": "Selection",
                "action": "flameshot gui",
            },
            {
                "display": "Desktop",
                "action": 'flameshot full -p "$HOME/Pictures/"',
            },
        ],
    },
    {
        "display": "Calendar",
        "action": "zenity --calendar"
    },
]


def menu(commands, prompt=":"):
    """
    Run Rofi menu given commands dictionary
    """
    command_displays = []
    command_actions = []
    command_prompts = []

    for command in commands:
        command_displays.append(command["display"])
        command_actions.append(command["action"])

        if command.get("prompt"):
            command_prompts.append(command["prompt"])
        else:
            command_prompts.append(prompt)

    # Format item display following Rofi format
    rofi_item_displays = "\n".join(command_displays)
    rofi_command = f'echo "{rofi_item_displays}" | {ROFI_COMMAND} "{prompt}"'
    # Execute the command and read the return selected index
    selected_idx = os.popen(rofi_command).read().strip()

    if selected_idx:
        selected_idx = int(selected_idx)
        action = command_actions[selected_idx]

        if isinstance(action, list):
            # Go into sub command
            menu(action, command_prompts[selected_idx])
        else:
            os.system(action)


menu(COMMANDS)

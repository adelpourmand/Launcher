#!/bin/bash

APP="$1"
APPNAME=$(basename "$APP" | sed 's/\..*//')

# Prompt user for custom name with Zenity
CUSTOMNAME=$(zenity --entry --title="Create Launcher" \
    --text="Enter launcher name:" \
    --entry-text="$APPNAME")

if [ -z "$CUSTOMNAME" ]; then
    CUSTOMNAME="$APPNAME"
fi

# Use the Adwaita executable icon as the default
DEFAULT_ICON="/usr/share/icons/Adwaita/scalable/mimetypes/application-x-executable.svg"

DESKTOP_FILE="$HOME/.local/share/applications/$CUSTOMNAME.desktop"

# Write .desktop file
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=$CUSTOMNAME
Exec="$APP"
Icon=$DEFAULT_ICON
Terminal=false
Categories=Utility;Accessories;
EOF

chmod +x "$DESKTOP_FILE"

# Copy to Desktop
cp "$DESKTOP_FILE" "$HOME/Desktop/"
chmod +x "$HOME/Desktop/$CUSTOMNAME.desktop"

# Refresh menu
update-desktop-database ~/.local/share/applications

# Confirmation dialog
zenity --info --title="Launcher Created" \
    --text="A launcher for '$CUSTOMNAME' has been created.\n\n\
- Desktop icon added\n\
- Menu entry under 'Accessories'\n\
- Default icon set to $DEFAULT_ICON"


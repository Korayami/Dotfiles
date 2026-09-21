#!/bin/bash


# sudo pacman -Syu
# sudo pacman -S yay

# yay -S hyprland

# curl -fsSL get.axeni.de/ambxst | sh

# ambxst install hyprland


# Quellordner und Zielordner definieren
QUELL_ORDNER="/home/$USER/.Dotfiles/dots/.config"
ZIEL_ORDNER="/home/$USER/.config"

# Stelle sicher, dass der Zielordner existiert
mkdir -p "$ZIEL_ORDNER"

# Iteration über alle Dateien im Quellordner
for datei in "$QUELL_ORDNER"/*; do
    # Prüfen, ob es sich wirklich um eine Datei handelt (und nicht um einen Ordner)
    if [ -f "$datei" ]; then
        # Dateiname ohne Pfad extrahieren
        dateiname=$(basename "$datei")
        # Alte Datei Backup
        mv "$ZIEL_ORDNER/$dateiname" "$ZIEL_ORDNER/$dateiname.bak"
        
        # Symlink erstellen (-s für symlink, -f zum Überschreiben falls existiert)
        ln -sf "$datei" "$ZIEL_ORDNER/$dateiname"
        
        echo "Symlink erstellt für: $dateiname"
    fi
done

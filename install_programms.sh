#!/bin/bash
# System Aktualisieren
sudo pacman -Syu

# Yay installieren
sudo pacman -S yay

# Mit yay Pakete installieren
yay -S hyprland xdg-desktop-portal-hyprland-git bat helix wq

# Ambxst Installieren
curl -fsSL get.axeni.de/ambxst | sh

# Quellordner und Zielordner definieren
QUELL_ORDNER="/home/$USER/.Dotfiles/dots/.config"
ZIEL_ORDNER="/home/$USER/.config"

# Stelle sicher, dass der Zielordner existiert
mkdir -p "$ZIEL_ORDNER"

# Iteration über ALLE Einträge (Dateien UND Ordner)
for pfad in "$QUELL_ORDNER"/*; do
    # Prüfen, ob der Pfad überhaupt existiert (fängt leere Ordner ab)
    if [ -e "$pfad" ]; then
        eintrag_name=$(basename "$pfad")
        ziel_pfad="$ZIEL_ORDNER/$eintrag_name"

        # 1. Überspringen, wenn am Ziel bereits der korrekte Symlink liegt
        if [ -L "$ziel_pfad" ]; then
            echo "Übersprungen (Symlink existiert bereits): $eintrag_name"
            continue
        fi

        # 2. Backup NUR erstellen, wenn am Ziel eine echtes Verzeichnis/Datei existiert
        if [ -e "$ziel_pfad" ]; then
            echo "Erstelle Backup für bestehende Konfiguration: $eintrag_name.bak"
            mv "$ziel_pfad" "$ziel_pfad.bak"
        fi

        # 3. Symlink erstellen
        ln -s "$pfad" "$ziel_pfad"
        echo "Symlink erstellt für: $eintrag_name"
    fi
done

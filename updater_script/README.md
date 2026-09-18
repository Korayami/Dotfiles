# AUTO Sync

Config lives in `/usr/share/scripts/autoupdate`. This directory has to manually be created:

```sh
# Grant single time Sudo rights
sudo -v
sudo mkdir /usr/share/scripts
sudo mkdir /usr/share/scripts/autoupdate

# Kopieren der dateien:
# Ordner cd wo diese datei hier liegt
cd home/$USER/path/to/folder/updater_script

sudo cp -r * /usr/share/scripts/autoupdate
sudo chmod +x /usr/share/scripts/autoupdate/sync_configs.sh
```

Then run the script like this:

```sh
/usr/share/scripts/autoupdate/sync_configs.sh
```

Or add it to your shell either by adding it as an alias to the config manually
Or if you use the fish shell, add it to your shell config automatically by running following command:
```sh
echo 'alias sync_configs="/usr/share/scripts/autoupdate/sync_configs.sh"' >> /home/$USER/.config/fish/config.fish
source /home/$USER/.config/fish/config.fish
```

Then you can run the script simply by writing `sync_configs`

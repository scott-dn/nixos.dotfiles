# nixos.dotfiles

NixOS 26.05 + KDE Plasma 6, managed with a flake, home-manager and plasma-manager.

| Path | Purpose |
|---|---|
| `flake.nix`, `flake.lock` | Inputs and their pinned commits |
| `configuration.nix` | System: boot, network, users, services |
| `home/` | User config, one module per tool (`default.nix` imports them) |
| `hardware-configuration.nix` | Generated for this machine only |

## Before `nixos-rebuild switch`

1. `git add -A` (flakes only see tracked files).
2. Git identity and GPG key: `home/git.nix`. Find the key ID with `gpg --list-secret-keys --keyid-format=long`.
3. Touchpad name and IDs: `home/plasma.nix`. Find them with `grep -i -B1 -A8 touchpad /proc/bus/input/devices`.
4. Hostname (`configuration.nix`) must match `nixosConfigurations.<name>` in `flake.nix`.
5. Username must match in `configuration.nix` and `flake.nix`. Don't rename an existing account.
6. New machine: regenerate `hardware-configuration.nix` with `nixos-generate-config`.
7. Adjust desktop widget positions (`home/plasma.nix`) and DNS (`configuration.nix`) if needed.
8. Validate: `sudo nixos-rebuild dry-build --flake ~/nixos.dotfiles#nixos`

## Apply

```bash
sudo nixos-rebuild switch --flake ~/nixos.dotfiles#nixos
```

Log out and back in afterwards. For Plasma or large updates use `boot` and reboot.

## Update packages

```bash
cd ~/nixos.dotfiles
nix flake update
sudo nixos-rebuild build --flake .#nixos
nix store diff-closures /run/current-system ./result
sudo nixos-rebuild switch --flake .#nixos
```

## Upgrade release

Change both URLs in `flake.nix` to the same release (e.g. `nixos-26.11` and `release-26.11`), then update as above.
Never change `system.stateVersion` or `home.stateVersion`.

## Roll back

Pick an older generation at boot, or `sudo nixos-rebuild switch --rollback`. Only the last 3 are kept.

## Notes

- plasma-manager runs widget and wallpaper scripts only when their content changes. To force a re-run:
  `rm ~/.local/share/plasma-manager/last_run_desktop_script_*` then `~/.local/share/plasma-manager/run_all.sh` inside Plasma.
- Panels and desktop widgets are recreated from `home/plasma.nix`; edit there, not by hand.
- Existing config files are renamed to `*.backup` on the first switch.
- Nix never deletes your data (`~/.gnupg`, `~/.local/share/Steam`, ...). Back up GPG keys separately.
- NixOS and home-manager use different option names (e.g. `programs.git.config` vs `.settings`); check which file a block is in.

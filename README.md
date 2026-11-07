# nixos.dotfiles

NixOS 26.05 + KDE Plasma 6, managed with a flake, home-manager, plasma-manager and nix4nvchad.

| Path                         | Purpose                                                       |
| ---------------------------- | ------------------------------------------------------------- |
| `flake.nix`, `flake.lock`    | Inputs and their pinned commits                               |
| `configuration.nix`          | System: boot, network, users, services                        |
| `home/`                      | User config, one module per tool (`default.nix` imports them) |
| `home/nvchad/`               | NvChad Lua config, copied to `~/.config/nvim` on switch       |
| `hardware-configuration.nix` | Generated for this machine only                               |

## Before `nixos-rebuild switch`

1. `git add -A` — flakes only see tracked files, untracked ones are ignored silently.
2. `sudo nixos-rebuild dry-build --flake ~/nixos.dotfiles#nixos`

## New machine

1. Install NixOS 26.05 with user `scott-dang`, then clone and regenerate the hardware config.
   The committed one holds this laptop's disk UUIDs and will not boot elsewhere.

```bash
nix-shell -p git --run \
  'git clone https://github.com/scott-dn/nixos.dotfiles ~/nixos.dotfiles'
cd ~/nixos.dotfiles
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```

2. Fix the machine-specific values:

| File                | Value                                  | Notes                                                                          |
| ------------------- | -------------------------------------- | ------------------------------------------------------------------------------ |
| `configuration.nix` | `networking.hostName`                  | must match `nixosConfigurations.<name>` in `flake.nix`                         |
| `configuration.nix` | `insertNameservers`                    | drop it unless the local DNS misbehaves                                        |
| `home/plasma.nix`   | touchpad `name`/`vendorId`/`productId` | `grep -i -B1 -A8 touchpad /proc/bus/input/devices`; wrong values fail silently |
| `home/plasma.nix`   | `desktop.widgets` positions            | pixels, currently for 1800x1125                                                |
| `home/git.nix`      | `signing.key`                          | `gpg --list-secret-keys --keyid-format=long`                                   |

3. Restore the secrets, which are not in the repo: `gpg --import <key>` and `~/.ssh/git` (chmod 600).
   Without the GPG key every commit fails, since `signByDefault` is on.
4. Build and switch (below), then: `passwd`, launch `nvim` once so lazy.nvim fetches plugins, `fprintd-enroll`.

Renaming the user means changing it in both `configuration.nix` and `flake.nix` — on an existing
account that creates a second empty one instead.

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

## Neovim

NvChad via nix4nvchad; `flake.nix` imports its module with `starterRepo = ./home/nvchad`.

- Edit `home/nvchad/`, never `~/.config/nvim` — every switch overwrites it. `git add` new files.
- LSP servers and formatters come from `extraPackages` in `home/neovim.nix`, pinned by `flake.lock`.
  Wire them up in `lua/configs/lspconfig.lua` and `lua/configs/formatter.lua`.
- Mason is disabled in `lua/plugins/init.lua`: its prebuilt binaries need `programs.nix-ld`,
  which is deliberately off. Add tools to `extraPackages` instead.
- Plugins are lazy.nvim's, fetched at runtime — pinned only by `lazy-lock.json`, not by Nix.
- `programs.neovim` must stay disabled (the module asserts on it).

## Notes

- plasma-manager runs widget and wallpaper scripts only when their content changes. To force a re-run:
  `rm ~/.local/share/plasma-manager/last_run_desktop_script_*` then `~/.local/share/plasma-manager/run_all.sh` inside Plasma.
- Panels and desktop widgets are recreated from `home/plasma.nix`; edit there, not by hand.
- Existing config files are renamed to `*.backup` on the first switch.
- Nix never deletes your data (`~/.gnupg`, `~/.local/share/Steam`, ...). Back up GPG keys separately.
- NixOS and home-manager use different option names (e.g. `programs.git.config` vs `.settings`); check which file a block is in.

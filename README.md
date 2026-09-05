# NixOS, スイッチ！

My personal NixOS deployment for my workstation, server, school laptop, and future systems. Farewell, Artix.

Now in Noctalia v5 flavour!

## Main Features

### Itsuku/Teppei

- Plymouth for quiet, clean boot
- Stylix (uses [Mountain colourscheme](https://github.com/mountain-theme/Mountain/))
- [NVF config](https://github.com/NotAShelf/nvf), by NotAShelf
- Wallpaper by susudust

Along with a bunch of other programs and preconfigured settings!

```
niri
noctalia
anki
btop
fish
foot
mpv
prismlauncher
qemu
retroarch
steam
swayimg
vesktop
waydroid
yazi
zathura
zen-beta
```

Itsuku and Teppei are used on my main workstation computers (A Framework 16 and ThinkPad T480 respectively). This is made with integration to my server in mind, hence the use of jellyfin-tui.

### Miyazu

- ZFS (filesystem)
- SSH for remote access
- ACME for creating valid local HTTPS certs
  - DDNS Updater to sync public IP with DNS record

Along with various homelab services:

```
jellyfin
lanraragi
navidrome
memos
opencloud
immich
radicale
vaultwarden
radarr
sonarr
sabnzbd
slskd
pi-hole
```

Miyazu is used on my main home server. Currently I'm just learning the hoops of making a server, and since I already know Nix, I thought it would be nice to try. So far I've been having a lot of fun and headaches, but mostly fun. Up until this point I've been storing everything locally on my workstation machines, so it's nice to have something dedicated to storing your data **somewhat** reliably. (somewhat meaning it entirely depends on the person maintaining the server)

## Rebuilding

To rebuild with the host you want, use this command followed by the host you want. In miyazu's case, it would be `nixos-rebuild switch --sudo --flake ~/.config/nixos#miyazu`.

## Showcase

![Empty desktop](/papes/showcase/2026-01-21-230536_niri.png)

![Desktop with launcher](/papes/showcase/2026-01-21-230440_niri.png)

![Desktop with control center and music showcase](/papes/showcase/2026-01-21-230712_niri.png)

![Overview showcase](/papes/showcase/2026-01-21-230937_niri.png)

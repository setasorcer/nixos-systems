# NixOS for Kyoko

My personal NixOS deployment for my workstation, server, school laptop, and future systems. Farewell, Artix.

## Main Features

### Itsuku/Teppei

- Niri (window manager)
- Waybar (taskbar)
- Swaync (notification daemon)
- rofi (launcher)
- foot (terminal)
- NVF (declarative config for neovim)

Along with a bunch of other programs!

```
anki
bluetui
btop
jellyfin-tui (jellyfin music player)
kdenlive (video editor)
mpv
picard (music tagger)
qbittorrent
steam
swayimg (image viewer)
vesktop
yazi (file manager)
zathura (pdf viewer)
zen-beta (web browser)
```

Itsuku is used on my main workstation computers (A Framework 16 and ThinkPad T480). This is made with integration to my server in mind. I used to use mpd for my music player, and good old mpv for watching Linux ISOs.

### Miyazu

- ZFS (filesystem)
- QuickSync support
- SSH with anti intrusion tools (endlessh, fail2ban)
- *arr for automating media organization
- Jellyfin for accessing movies, music, books, and TV shows
- Immich for storing personal photos
- Copyparty for simple file uploading/sharing
- Deluge for downloading Linux ISOs

Miyazu is used on my main home server. Currently I'm just learning the hoops of making a server, and since I already know Nix, I thought it would be nice to try. So far I've been having a lot of fun and headaches, but mostly fun. Up until this point I've been storing everything locally on my workstation machines, so it's nice to have something dedicated to storing your data **somewhat** reliably. (somewhat meaning it entirely depends on the person maintaining the server)

## Rebuilding

To rebuild with the host you want, use this command followed by the host you want. In miyazu's case, it would be `nixos-rebuild switch --sudo --flake ~/.config/nixos#miyazu`.

## Showcase

![Empty desktop](/papes/showcase/2025-10-04-143158_niri.png)

![Desktop with rofi](/papes/showcase/2025-10-04-143201_niri.png)

![Desktop with swaync and PEAK song](/papes/showcase/2025-10-04-143211_niri.png)

![Overview with PEAK album](/papes/showcase/2025-10-04-154749_niri.png)

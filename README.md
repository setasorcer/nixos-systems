# NixOS for Kyoko

My personal NixOS deployment for my workstation, server, school laptop, and future systems. Farewell, Artix.

Now in noctalia-shell flavour!

## Main Features

### Itsuku/Teppei

- Niri (window manager)
- Noctalia Shell (desktop shell)
- Cosmic Greeter
- Stylix (uses [Mountain colourscheme](https://github.com/mountain-theme/Mountain/))
- [NVF config](https://github.com/NotAShelf/nvf), by NotAShelf

Along with a bunch of other programs and preconfigured settings!

```
anki
btop
foot
jellyfin-tui (jellyfin music player)
kdenlive (video editor)
mpv
picard (music tagger)
qemu
qbittorrent
retroarch
steam
swayimg (image viewer)
vesktop
yazi (file manager)
zathura (pdf viewer)
zen-beta (web browser)
```

Itsuku and Teppei are used on my main workstation computers (A Framework 16 and ThinkPad T480 respectively). This is made with integration to my server in mind, hence the use of jellyfin-tui.

### Miyazu

- ZFS (filesystem)
- QuickSync support
- SSH with anti intrusion tools (endlessh, fail2ban) (Known issue: intrusion tools do practically nothing, although ssh is local only)
- *arr for automating media organization
- Jellyfin for accessing movies, music, books, and TV shows
- Immich for storing personal photos
- Audiobookshelf and Komga for viewing/listening to books and manga
- Filebrowser for simple file uploading/sharing
- Deluge/Sabnzbd/Slskd for downloading Linux ISOs

Miyazu is used on my main home server. Currently I'm just learning the hoops of making a server, and since I already know Nix, I thought it would be nice to try. So far I've been having a lot of fun and headaches, but mostly fun. Up until this point I've been storing everything locally on my workstation machines, so it's nice to have something dedicated to storing your data **somewhat** reliably. (somewhat meaning it entirely depends on the person maintaining the server)

## Rebuilding

To rebuild with the host you want, use this command followed by the host you want. In miyazu's case, it would be `nixos-rebuild switch --sudo --flake ~/.config/nixos#miyazu`.

## Showcase

![Empty desktop](/papes/showcase/2026-01-21-230536_niri.png)

![Desktop with launcher](/papes/showcase/2026-01-21-230440_niri.png)

![Desktop with control center and music showcase](/papes/showcase/2026-01-21-230712_niri.png)

![Overview showcase](/papes/showcase/2026-01-21-230937_niri.png)

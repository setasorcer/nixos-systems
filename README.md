# NixOS for Kyoko

My personal NixOS deployment for my desktop, laptop, and maybe future systems as well. Farewell, Artix. You have served me well.

## Information

Unfortunately the only experience I have with installing this on a new system is when I installed Nix on my laptop, which I did around 5 months ago. My best advice would be to just create a new Nix installation, enable flakes, and then rebuild the new system with the host you desire.

For reference, **miyazu** is made with a desktop in mind, whereas **itsuku** is made with a laptop (specifically a ThinkPad T480) in mind. You may fork this repository and edit it to your needs.

My desktop is all AMD, so you may need to reconfigure some options if you are an Nvidia or Intel user. For laptops other than a T480, remove the import from nixos-hardware in `/hosts/itsuku/default.nix` and try to look for a predefined config for your laptop [here](https://github.com/NixOS/nixos-hardware). If you can't find a config for your specific laptop, you should still be fine but you may miss out on some model-specific features you don't know about, or encounter a weird issue with your specific laptop. Whatever the case is, this is out of my expertise.

Otherwise, don't be afraid to look at all the code. It shouldn't be too overwhelming.

## So what's the difference?

Other than the ones I've described earlier, itsuku comes with a more "compact" waybar (The workspace buttons are moved to the left, and battery modules are activated). Animations are also disabled in order to save battery. Programs that I only want on specific systems are also present, for example Anki is only on itsuku (located in `/hosts/itsuku/default.nix`). Host-specific options right now are very messy, and I apologize for that until I can find out a not messy way to have every host-specific setting where I want it, whether it be in the default.nix or the appropriate .nix files.

## Rebuilding

To rebuild with the host you want, use this command followed by the host you want. In miyazu's case, it would be:

```nixos-rebuild switch --use-remote-sudo --flake ~/.config/nixos#miyazu```

### Screenshots

![Empty desktop](/papes/showcase/2025-05-31-220016_hyprshot.png)

![Desktop with rofi](/papes/showcase/2025-05-31-220038_hyprshot.png)

![Desktop with PEAK song](/papes/showcase/2025-06-12-193549_hyprshot.png)

![Desktop with swaync and PEAK song](/papes/showcase/2025-05-31-220327_hyprshot.png)

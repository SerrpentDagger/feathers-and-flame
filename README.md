# Feathers and Flame

This setup combines the snappiness and good hardware support of CachyOS with the gorgeous minimalism of Niri and Noctalia Shell.
It's completely modular; you can either breeze through the install menu, pressing 'Yes' to get a cohesive and well-configured system to start off with, or you can pick through selectively to avoid your particular raisins.

## Some highlights

- Niri, Noctalia, CachyOS (obv)
- Comprehensive theming setup; colours chosen dynamically from wallpaper or specific theme per wallpaper
- Wallpaper keybinds for favourite groups: get a random wallpaper from any favourite category
- Highly keyboard-driven with carefully thought-out bindings for most use
- `cbonsai` screensaver
- Night light with `wlsunset`
- Fine-tuned window rules and shell configuration; custom hot-swap rules
- LUKS-encrypted auto-login
- Refined LazyVim out of the box
- Advanced power-management with `tlp`
- Performance optimisations with `gamemode`
- Privacy-focused browser setup with Tor and Mullvad browsers
- Hide supurfluous `.desktop` entries to keep the launcher clean
- File-sharing binds for `localsend`
- Improved Nautilus integration for LazyVim and Alacritty
- Preconfigured Virt-Manager with QEMU
- Pre-set mimetypes
- Easy-installation of suggested programs
- Limine snapshots

## Showcase Pictures

<img width="960" height="540" alt="flashy colors overview screen" src="https://serpentdagger.com/assets/images/feathers-and-flame/color-splash-overview.png" />
<img width="960" height="540" alt="nord dark moon wallpaper" src="https://serpentdagger.com/assets/images/feathers-and-flame/dark-side-nord-showcase.png" />
<img width="960" height="540" alt="keybind showcase peaceful cat background" src="https://serpentdagger.com/assets/images/feathers-and-flame/catppuccin-keybinds.png" />

## Installation

Installation takes the form of a single `curl` command in an appropriate fresh CachyOS install.

### of CachyOS

First, install CachyOS normally (from a flashed USB with [their iso](https://cachyos.org/download/)), subject to the following notes:

1. Select `Limine` as your bootloader.
   <div>
      <img width="564" height="309" alt="limine bootloader selection" src="https://serpentdagger.com/assets/images/feathers-and-flame/choose-limine.jpg" />
   </div>
2. Encrypt your drive by selecting `btrfs` and `Encrypt System` in the `Partitions` section.
   <div>
      <img width="564" height="309" alt="btrfs drive encryption" src="https://serpentdagger.com/assets/images/feathers-and-flame/btrfs-encrypted-partitioning.jpg" />
   </div>
3. Select `Niri` in the `Desktop` section.
4. You can uncheck Firefox in the `Packages` section, since Feathers can install Mullvad and Tor Browsers for you.
   <div>
      <img width="1128" height="309" alt="package selection" src="https://serpentdagger.com/assets/images/feathers-and-flame/package-selection.jpg" />
   </div>
5. Choose the same password for your user login as you did for encryption.
   <div>
      <img width="564" height="309" alt="login password same" src="https://serpentdagger.com/assets/images/feathers-and-flame/login-details-same-password.jpg" />
   </div>
6. Reboot!

### of Feathers and Flame

The setup may install properly on other Arch-based systems, or a 'dirty' CachyOs install, but testing is done on clean CachyOs installations. If you're unsure, feel free to ask in an issue, or test in a VM first.

1. Once you've booted into your basic installation, press `Mod+Return` to open a terminal and run:
`curl -fsSL https://serpentdagger.com/feathers-and-flame/install | bash`. You'll be greeted by a flashy owl:
   <div>
      <img width="478" height="520" alt="feathers installer welcome" src="https://serpentdagger.com/assets/images/feathers-and-flame/installer-welcome.jpg" />
   </div>
2. Select the components you want, or just `Ctrl + A` for all of them!
   <div>
      <img width="478" height="520" alt="installer select components for install" src="https://serpentdagger.com/assets/images/feathers-and-flame/installer-main-selection.jpg" />
   </div>
3. You will be asked for confirmation before installing:
   <div>
      <img width="478" height="520" alt="installer confirm selection" src="https://serpentdagger.com/assets/images/feathers-and-flame/installer-confirm-selection.jpg" />
   </div>
4. After pressing `Yes`, the installer will take a while to download and configure the system for you, depending on your bandwidth and hardware. After it's done, you will be prompted to reboot:
   <div>
      <img width="478" height="520" alt="installer finished reboot prompt" src="https://serpentdagger.com/assets/images/feathers-and-flame/installer-finished-reboot.jpg" />
   </div>
5. Once you've rebooted again, Feathers and Flame is ready for your enjoyment! I hope you have as great a time using it as I did setting it up!
   <div>
      <img width="564" height="309" alt="install finished welcome screen boot" src="https://serpentdagger.com/assets/images/feathers-and-flame/install-finished-first-boot.jpg" />
   </div>

### Trouble?

The installer keeps track of what components have been finished successfully, so if something goes wrong mid-install you can continue where you left off, or try again, by re-running the installer with `bash ~/.local/share/feathers-and-flame/install.sh`. It will ask if you want to pick up where you left off, or give you the opportunity to skip a component if it doesn't seem to work for some reason. This is also used later in the update script to avoid refreshing or installing unselected components on update.

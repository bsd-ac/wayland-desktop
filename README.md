# wayland-desktop
[![Build Status](https://travis-ci.com/bsd-ac/wayland-desktop.svg?branch=master)](https://travis-ci.com/bsd-ac/wayland-desktop)

gentoo overlay for wayland related ebuilds + a tiny desktop environment dotfiles

## Activate overlay (via layman)
Read this to get familiar with layman: https://wiki.gentoo.org/wiki/Layman

```
    $ layman -a wayland-desktop
```

## Using packages from the overlay
If you are running on the stable branch by default, allow **~amd64** keyword files from this repository.   
Make sure that `/etc/portage/package.accept_keywords` exists and is a directory.

```
    $ echo "*/*::wayland-desktop ~amd64" >> /etc/portage/package.accept_keywords/wayland-desktop
```

Now you can install packages from the overlay.
For example:

```
    # emerge --ask --verbose gui-wm/wayfire-de
```

## Wayfire DE

### Disclaimer

The minimalistic Wayfire Desktop Environment package present here is an **opinionated** setup.   
Be polite in your request and give a clear indication about the changes you wish for.

### Setting up Wayfire DE

First install the meta package: [gui-apps/wayfire-de](gui-apps/wayfire-de).<br/>
This will install all the necessary dependencies and the command `wayfire-de-setup`.

Run the command `wayfire-de-setup` and log back in using your preferred login manager or tty.

### Setup includes

While not a full fledges Desktop Environment of the likes of Gnome/KDE Plasma, `wayfire-de-setup` includes quite a few goodies:

1. Simple and sane [Wayfire](https://github.com/WayfireWM/wayfire) configuration
2. Simple and sane [Waybar](https://github.com/Alexays/Waybar) configuration 
  - Taskbar to minimize/maximize apps 
  - wifi, volume, battery, clock icons
  - Notification tray (experimental)
3. Consistent GTK themes - [icons + windows + cursors](x11-themes/)
4. Consistent Terminator themes
5. Lock/logout menu + application grid + dmenu - [NWG Launchers](https://github.com/nwg-piotr/nwg-launchers)
6. Simple and lightweight wallpaper rotation - [oguri](https://github.com/vilhalmer/oguri) + [rotation script](gui-apps/wayfire-de/files/9999/wallpaper_rotate) using ogurictl
7. Simple screenshots - fullscreen as well as area select (grim + slurp)
8. Lock screen - [swaylock-effects](gui-apps/swaylock-effects)


### UnixPron

![Screenshot 1](https://openpgpkey.bsd.ac/screenshot1.webp)
![Screenshot 2](https://openpgpkey.bsd.ac/screenshot2.webp)
![Screenshot 3](https://openpgpkey.bsd.ac/screenshot3.webp)
![Screenshot 4](https://openpgpkey.bsd.ac/screenshot4.png)
![Screenshot 5](https://openpgpkey.bsd.ac/screenshot5.png)
![Screenshot 6](https://openpgpkey.bsd.ac/screenshot6.png)

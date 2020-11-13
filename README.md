# wayland-desktop
[![Build Status](https://travis-ci.com/epsilon-0/wayland-desktop.svg?branch=master)](https://travis-ci.com/epsilon-0/wayland-desktop)

gentoo overlay for wayland related ebuilds

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

`wayfire-de-setup` includes quite a few goodies:

1. Featureful [Wayfire](https://github.com/WayfireWM/wayfire) configuration
2. GTK goodies - [icons + theme + cursors](x11-themes/)
3. [NWG Launchers](https://github.com/nwg-piotr/nwg-launchers) - log out menu + grid
4. Wallpaper rotation - [oguri](https://github.com/vilhalmer/oguri) + rotation script using ogurictl
5. [Waybar](https://github.com/Alexays/Waybar) - window list taskbar + basic system info
6. Terminator - GTK theme compatible colors
7. Screenshotting - fullscreen as well as area select (grim + slurp)


### UnixPron

![Screenshot 1](https://openpgpkey.bsd.ac/screenshot1.webp)
![Screenshot 2](https://openpgpkey.bsd.ac/screenshot2.webp)
![Screenshot 3](https://openpgpkey.bsd.ac/screenshot3.webp)
![Screenshot 4](https://openpgpkey.bsd.ac/screenshot4.png)
![Screenshot 4](https://openpgpkey.bsd.ac/screenshot5.png)

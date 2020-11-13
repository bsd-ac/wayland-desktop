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

First install the meta package: [gui-apps/wayfire-de](gui-apps/wayfire-de)
This will install all the necessary dependencies and the command `wayfire-de-setup`.

Run the command `wayfire-de-setup` and log back in using your preferred login manager or tty.

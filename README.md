# wayland-desktop
[![pkgcheck](https://github.com/bsd-ac/wayland-desktop/workflows/pkgcheck/badge.svg)](https://github.com/bsd-ac/wayland-desktop/actions?query=workflow:pkgcheck)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](https://wiki.gentoo.org/wiki/Contributing_to_Gentoo)

gentoo overlay for wayland related ebuilds

## Activate overlay (via eselect-repository)

```
    $ eselect repository enable wayland-desktop
```

## Using packages from the overlay
If you are running on the stable branch by default, allow **~amd64** keyword files from this repository.
Make sure that `/etc/portage/package.accept_keywords` exists and is a directory.

```
    $ echo "*/*::wayland-desktop ~amd64" >> /etc/portage/package.accept_keywords/wayland-desktop
```

Now you can install packages from the overlay.

```
    # emerge --ask --verbose gui-apps/pico-wayfire
```

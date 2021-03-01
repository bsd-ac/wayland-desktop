# wayland-desktop
[![pkgcheck](https://github.com/bsd-ac/wayland-desktop/workflows/pkgcheck/badge.svg)](https://github.com/bsd-ac/wayland-desktop/actions?query=workflow:pkgcheck)
[![repoman](https://github.com/bsd-ac/wayland-desktop/workflows/repoman/badge.svg)](https://github.com/bsd-ac/wayland-desktop/actions?query=workflow:repoman)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](https://wiki.gentoo.org/wiki/Contributing_to_Gentoo)
[![chat on freenode](https://img.shields.io/badge/chat-on%20freenode-brightgreen.svg)](https://webchat.freenode.net/#gentoo-science)

Gentoo overlay for Wayland related ebuilds

## Activate overlay (via eselect-repository)

```
    $ eselect repository enable wayland-desktop
    $ emaint sync --repo wayland-desktop
```

## Using packages from the overlay

### AMD64

If running on the stable **amd64** branch by default, unstable **~amd64** keywords must be allowed for packages from this repository.
Make sure that `/etc/portage/package.accept_keywords` exists and is a directory.

```
    $ echo "*/*::wayland-desktop ~amd64" > /etc/portage/package.accept_keywords/wayland-desktop
    $ emerge --ask --verbose gui-apps/pico-wayfire
```

### Other ARCHs

Unless really important, all ebuilds from this overlay will only have the **~amd64** *USE* flag, for ease of maintenance.

If running on a different *ARCH*, all keywords must be accepted.

```
    $ echo "*/*::wayland-desktop **" > /etc/portage/package.accept_keywords/wayland-desktop
    $ emerge --ask --verbose gui-apps/pico-wayfire
```

## Licensing and contributing

All ebuilds in this repository are under the [ISC license](LICENSE).

Any users who wish to contribute should know and be comfortable with this. When making a PR, make sure to add the appropriate name and years to the top of the ebuilds.

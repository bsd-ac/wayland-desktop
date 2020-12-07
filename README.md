# wayland-desktop
[![Build Status](https://travis-ci.com/bsd-ac/wayland-desktop.svg?branch=master)](https://travis-ci.com/bsd-ac/wayland-desktop)

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
For example:

```
    # emerge --ask --verbose gui-apps/pico-wayfire
```

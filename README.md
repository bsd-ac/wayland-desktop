# wayland-desktop
gentoo overlay for wayfire ebuilds and other wayfire apps

## Overview
This repository contains a lot of ebuilds for the wayland desktop environment and window manager `wayfire`. There are also quite a few utilities included to help work with this environment.

## Installation

It is generally a good idea to use one of the two following methods for all overlays and stick with it, unless you want to specifically mix and match, causing a mess of files.

### Method 1 (via layman)
Read this to get familiar with layman: https://docs.ansible.com/ansible/latest/modules/layman_module.html, https://wiki.gentoo.org/wiki/Layman

```
    $ layman -a wayfire-desktop
```

### Method 2 (manual)

As of version >= 2.2.16 of Portage, **wayfire-desktop** is can be installed (on Gentoo) via the [new plug-in sync system](https://wiki.gentoo.org/wiki/Project:Portage/Sync).

The following are short form instructions. If you haven't already installed **git**(1), do so first:

```
    $ emerge --ask --verbose dev-vcs/git 
```

Next, create a custom `/etc/portage/repos.conf` entry for the **wayfire-desktop** overlay, so Portage knows what to do. Make sure that `/etc/portage/repos.conf` exists, and is a directory. Then, fire up your favourite editor:

```
    $ vim /etc/portage/repos.conf/wayfire-desktop.conf
```

and put the following text in the file:

```
    [wayfire-desktop]

    location = /usr/local/portage/wayfire-desktop
    sync-type = git
    sync-uri = https://github.com/epsilon-0/wayfire-desktop.git
    priority = 50
    auto-sync = yes
```

Then run:

```
    $ emaint sync --repo wayfire-desktop
```

## Using packages from the overlay
If you are running on the stable branch by default, allow **~amd64** keyword files from this repository. Make sure that `/etc/portage/package.accept_keywords` exists, and is a directory. Then issue:

```
    $ echo "*/*::wayfire-desktop ~amd64" >> /etc/portage/package.accept_keywords/wayfire-desktop
```

Now you can install packages from the overlay. For example:

```
    # emerge --ask --verbose gui-wm/wayfire
```

credit (for installation methods): [sakaki-tools](https://github.com/sakaki-/sakaki-tools)

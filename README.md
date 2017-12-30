### About

A simple and colorful SDDM theme

[![Build Status](https://img.shields.io/travis/AlfredoRamos/urbanlifestyle-sddm-theme.svg?style=flat-square&maxAge=3600)](https://travis-ci.org/AlfredoRamos/urbanlifestyle-sddm-theme) [![Latest stable version](https://img.shields.io/github/tag/AlfredoRamos/urbanlifestyle-sddm-theme.svg?style=flat-square&maxAge=3600&label=stable)](https://github.com/AlfredoRamos/urbanlifestyle-sddm-theme/releases/latest) [![License](https://img.shields.io/github/license/AlfredoRamos/urbanlifestyle-sddm-theme.svg?style=flat-square)](https://raw.githubusercontent.com/AlfredoRamos/urbanlifestyle-sddm-theme/master/LICENSE)

Background image *Urban LifeStyle* by [snyp](http://r0pyns.deviantart.com/) (r0pyns) was taken from [anime-pictures.net](https://anime-pictures.net/pictures/view_post/100739)

### Dependencies
- Qt >= 5.6

### Preview
![Urban LifeStyle](https://raw.githubusercontent.com/AlfredoRamos/urbanlifestyle-sddm-theme/master/images/urbanlifestyle.jpg)

### Installation
**Arch Linux**

It is available on the AUR, you can install it with `makepkg` or using an AUR helper.

Using `makepkg`:

```shell
git clone https://aur.archlinux.org/urbanlifestyle-sddm-theme.git
cd urbanlifestyle-sddm-theme
makepkg -Ccsi
```
___

Using [trizen](https://github.com/trizen/trizen) AUR helper:

```shell
trizen -S --aur urbanlifestyle-sddm-theme
```

**Other GNU/Linux distros**
- Download the [latest release](https://github.com/AlfredoRamos/urbanlifestyle-sddm-theme/releases/latest)
- Decompress the `*.zip` or `*.tar.gz` file
- Copy all files and directories into `/usr/share/sddm/themes/urbanlifestyle/`

### Usage
- Open up your configuration file and set `urbanlifestyle` as your current theme

```shell
[Theme]
# Current theme name
Current=urbanlifestyle
```

For more info, please refer to [SDDM configuration](https://github.com/sddm/sddm/wiki/0.16.0-Release-Announcement#configuration).

### Configuration
You can change some theme settings to fit your preferences, these values are located in the [theme.conf](https://github.com/AlfredoRamos/urbanlifestyle-sddm-theme/blob/master/theme.conf) file.

The avatar image size should be at least 100x100 px. For more information, refer to the Arch wiki.
- [SDDM: Changing your avatar](https://wiki.archlinux.org/index.php/SDDM#Changing_your_avatar)

For the time and date format, please refer to the Qt QML docs.
- [Date QML Type](https://doc.qt.io/qt-5/qml-qtqml-date.html)

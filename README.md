### About
Urban LifeStyle SDDM Theme is licensed under [GNU GPL-3.0+](https://www.gnu.org/licenses/gpl-3.0.txt)

Background image "Urban LifeStyle" by [snyp](http://r0pyns.deviantart.com/) (r0pyns) was taken from [anime-pictures.net](https://anime-pictures.net/pictures/view_post/100739)

### Preview
![Urban LifeStyle](https://raw.githubusercontent.com/AlfredoRamos/sddm-urbanlifestyle-theme/master/urbanlifestyle/images/urbanlifestyle.jpg)

### Install
**Arch Linux** (using [pacaur](https://wiki.archlinux.org/index.php/Pacaur))

```shell
pacaur -Sa sddm-urbanlifestyle-theme
```
___
**Other GNU/Linux distros**
* Download the [latest release](https://github.com/AlfredoRamos/sddm-urbanlifestyle-theme/releases/latest).
* Decompress the *.zip/*.tar.gz file.
* Copy the `urbanlifestyle` folder to your SDDM theme directory, by default `/usr/share/sddm/themes`

### Configuration
* Open up your `/etc/sddm.conf` file and set `urbanlifestyle` as your current theme.

```shell
[Theme]
# Current theme name
Current=urbanlifestyle
```

The avatar image size should be at least 90x90 px. For more information, refer to the Arch wiki.
- [[SDDM] Changing your avatar](https://wiki.archlinux.org/index.php/SDDM#Changing_your_avatar).

### Known issues
- Password field has no focus (see [sddm/sddm#501](https://github.com/sddm/sddm/issues/501)). To fix this issue you will need to patch the theme (see [password_focus_fix.patch](https://aur.archlinux.org/cgit/aur.git/plain/password_focus_fix.patch?h=sddm-urbanlifestyle-theme)) or wait until [SDDM 0.14](https://github.com/sddm/sddm/milestones/0.14) is released. If you're running Arch Linux and installed the theme from the AUR, the theme has been already patched.
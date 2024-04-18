# Polybar Russian Roulette
🔫 Randomly kill any window with this Polybar button

# Pre-requisites

* [Polybar](https://github.com/polybar/polybar)
* [Dunst](https://github.com/dunst-project/dunst)
* [Wmctrl](https://github.com/Conservatory/wmctrl)
* [Xdotool](https://github.com/jordansissel/xdotool)
* [Xkill](https://gitlab.freedesktop.org/xorg/app/xkill)

# Install

## 1. Copy .ini and .sh files in your Polybar config

```sh
cp roulette.sh ~/.config/polybar/scripts/
cp RussianRoulette.ini ~/.config/polybar/modules
```

## 2. Ensure roulette.sh is executable

```sh
chmod +x ~/.config/polybar/scripts/roulette.sh
``` 

## 3. Add `russian-roulette` to your Polybar config

Example:

```ini
# ...
modules-right = russian-roulette clock battery notifications # ...
# ...
```

## 4. Reload your Polybar

## 5. You're now ready to play!

<p align="center">
    <img src="https://media1.tenor.com/m/tCzhW8X5fVAAAAAC/buckshot-roulette.gif" width="50%"
</p>
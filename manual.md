# Manual steps post install

## Apps
  - Download Chrome
  - Download [Alfred](https://www.alfredapp.com/)
      - Appearance > Options > Save position when dragging Alfred main window
  - Download [Shady](https://download.cnet.com/Shady/3000-2094_4-75784600.html)
  - Download [Karibiner Elements](https://karabiner-elements.pqrs.org/)
  - Download [iTerm2](https://www.iterm2.com/)
  - Download [Whatsapp](https://www.whatsapp.com/download)
  - Download [Key codes](https://manytricks.com/keycodes/)
  - Download [Keybase](https://keybase.io/docs/the_app/install_macos)

## Desktop background
  - Vader2 in desktop_backgrounds folder

## Moom
  - Download moom in the app store
  - Import moom custom settings:
  ```sh
  defaults import com.manytricks.Moom ~/dotfiles/moom/moom.plist
  ```

## Keymou
  - Download Keymou in the app store
  - Import custom keymou settings:
      - Figure out how to do this

## General settings

  - Command J (view options):
      - Icon size: Smallest
      - Grid spacing: Default
      - Text size: 10
      - Label position: Right
      - Sort by: Name

  - Finder Settings:
      - View > Show Status Bar
      - View > as Columns
      - Preferences:
          - General:
              - Show these items on the desktop:
                  - External disks
                  - CDs, DVDs, and oPods
              - New windows show: home user
              - Uncheck "Open folders in tabs instead of new windows
          - Sidebar:
              - Check items show in sidebar

## System preferences:

  - General:
      - Appearance: Auto

  - Security and Privacy
      - General
          - Require password immediately after sleep
          - Show message when screen is locked:
              - "Property of Steve SanPietro. If found, call (631) 877 - 3110, or email sanpietro.steve@gmail.com."

  - Mission Control Settings:
      - Uncheck:
          - Automatically rearrange spaces based on most recent use
          - When switching to an application, switch to a space with open
              windows for the application
          - Group windows by application

  - Keyboard:
      - Keyboard:
          - Key repeat: fast
          - Delay until repeat: short
      - Shortcuts:
          - App shortcuts:
              - "Lock Screen": ^Shift=
              - "Force Quit...": Option Command Q
              - "Zoom": Option Control =

    - Touchbar:
      - Keyboard:
          - "Touch bar showos": Expanded Control Strip
          - Customize control strip:
              - Remove everything except brightness, volume, and keyboard
                  brightness
              - Add space

  - Trackpad:
      - Point and click:
          - Secondary click
          - Tap to click
          - Click light
          - Tracking speed: 6/10
      - Scroll and zoom:
          - All
      - More gestures:
          - All

  - Accessibility
      - Mouse and trackpad
          - Trackpad options
              - Enable dragging
                  - 3 finger
      - Zoom
          - Use scroll gesture with modifier keys to zoom ^Control

  - Dock
      - Size: small
      - Magnification: Min
      - Position on screen: left
      - Automatically hide and show dock

  - Displays
      - Uncheck True Tone

## ITerm2

TODO: figure out why this isn't in the iterm profile.

- Set font to fantasque-sans-mono size 14
- Maximize window:
    By default iTerm2 opens as a small window. But in my workflow, I want all my
    windows maximized when they open. If you wan the same, you can go to
    Preferences → Profiles → Window → Settings for New Windows to set Columns and
    Rows of the new window.
- Preferences -> Profiles -> Keys -> Delete all key mappings
- Preferences -> Profiles -> Keys -> Left Option Key: Esc+

## M1 Macs

[Disable emoji key](https://www.howtogeek.com/708537/how-to-disable-the-mac-keyboards-emoji-shortcut/#:~:text=Select%20the%20drop%2Ddown%20next%20to%20the%20Globe%20icon.&text=From%20here%2C%20you%20can%20choose,to%20disable%20the%20Emoji%20keyboard.)

## Local Gitconfig

If you need to set a work user for github, create a `~/.local-github` file with
the following contents:

```
[user]
  name = <<username>>
  email = <<email>>
```

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
  - Download [Logitech Options+](https://www.logitech.com/en-us/software/options.html) Software
      - Open Logi Options app > More > Backups > Restore settings from backup > choose most recent backup
  - Download [Moom](https://www.synaptics.com/products/displaylink-graphics/downloads/macos)
  - Download [Keymou](https://manytricks.com/keymou/)
  - Download [DisplayLinkManager](https://www.synaptics.com/products/displaylink-graphics/downloads/macos-connectivity-1.8.1?filetype=exe)

## Desktop background
  - Vader2 in desktop_backgrounds folder

## Moom
  - Get license from email
  - Import moom custom settings:
  ```sh
  defaults import com.manytricks.Moom ~/dotfiles/moom/moom.plist
  ```
  If you make a change to the Moom settings and want to import those changes,
  ```sh
  defaults export com.manytricks.Moom ~/dotfiles/moom/moom.plist
  ```

## Keymou
  - Get license from email
  - Import custom keymou settings:
      - Figure out how to do this

## General settings

  - Command J (view options):
      - Icon size: Smallest
      - Grid spacing: Default
      - Text size: 10
      - Label position: Right
      - Stack by: Kind
      - Sort by: Name

  - Finder Settings:
      - View > Show Status Bar
      - View > as Columns
      - Preferences:
          - General:
            - Show these items on the desktop:
                - External disks
                - CDs, DVDs, and iPods
            - Uncheck Harddisks
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
              - Property of Steve SanPietro. If found, call (631) 877 - 3110, or email sanpietro.steve@gmail.com.

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
      - Press globe to "Do Nothing"
      - Text
      - Delete all find/replaces
      - Shortcuts:
          - App shortcuts:
              - "Lock Screen": ^Shift=
              - "Force Quit...": Option Command Q
              - "Minimize": Command+k
      - Spotlight:
          - Uncheck
          - "Show Spotlight Search" (apple space)
          - "Show Finder search window" (option apple space)

    - Touchbar:
      - Keyboard:
          - "Touch bar shows": Expanded Control Strip
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
      - Pointer Control > Mouse and trackpad
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
      - Other Modules > Battery (Menu Bar) > Check Show percentage

  - Displays
      - Select the right monitor as the primary monitor and arrange correctly

  - Notifications
      - Slack
          - Allow notifications

## ITerm2

TODO: figure out why this isn't in the iterm profile.

- Set font to fantasque-sans-mono size 14
- Maximize window
- Preferences -> Profiles -> Keys -> Delete all key mappings
- Preferences -> Profiles -> Keys -> Left Option Key: Esc+

## Local Gitconfig

If you need to set a work user for github, create a `~/.local-github` file with
the following contents:

```
[user]
  name = <<username>>
  email = <<email>>
```

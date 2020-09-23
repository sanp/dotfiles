# Manual steps post install

## Apps
  - Download Chrome
  - Download [Alfred](https://www.alfredapp.com/)
      - Appearance > Options > Save position when dragging Alfred main window
  - Download [Shady](https://download.cnet.com/Shady/3000-2094_4-75784600.html)
  - Download [Karibiner Elements](https://karabiner-elements.pqrs.org/)
  - Download [iTerm2](https://www.iterm2.com/)

## Desktop background
  - [Earth from ISS background](https://www.jetsoncreative.com/mac-dynamic-desktop-store/earth-mac)
    Download, put in Pictures folder and then set as desktop background.

## Moom
  - Download [Moom](https://manytricks.com/moom/)
  - Import moom custom settings:
  ```sh
  defaults import com.manytricks.Moom ~/dotfiles/moom/moom.plist
  ```

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


## ITerm2

- Set font to fantasque-sans-mono size 14
- Maximize window:
    By default iTerm2 opens as a small window. But in my workflow, I want all my
    windows maximized when they open. If you wan the same, you can go to
    Preferences → Profiles → Window → Settings for New Windows to set Columns and
    Rows of the new window.

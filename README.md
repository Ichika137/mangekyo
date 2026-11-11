# ######################################万華鏡####################################### #
 ------------------------------------------------- MANGEKYŌ ------------------------------------------------- 

 # A lightweigh, Bash powered wallpaper rotation engine for Linux 
Mangekyō is a personal Linux automation project that evolved from a simple wallpaper command into a category
aware wall paper rotation script. 
 
 It uses a Fisher-Yates shuffle algorithm, indipendent wallpaper queues,  time based category selection, and
 automatic backgroud color matching.

# Features
-Fisher–Yates shuffling: Randomizes the order of wallpaper images.
-Two independent categories: Maintains separate arrays and selection indexes for each category.
-Non-repeating cycles: Displays each image once per category cycle before reshuffling. An image may repeat at the boundary between cycles.
-Time-based scheduling: Automatically switches to the secondary category during a configured time window.
-Background color matching: Uses ImageMagick to calculate a representative image color for the wallpaper background.
-Filename-based categorization: Organizes wallpapers using customizable filename keywords.
-X11 desktop support: Applies wallpapers through feh.

# Requirements
Mangekyō currently targets Linux desktops running X11.

## Dependencies
-Bash 4.3 or newer
-feh
-ImageMagick (magick)
-GNU findutils
-GNU coreutils (od, sleep, and related utilities)

On Fedora, the main external packages can be installed with:
``` bash
sudo dnf install feh ImageMagick
```

Wayland and Hyprland support are not included in this release.

# Configuration
Edit the configuration section near the beginning of mangekyo.sh.

# Wallpaper directory
WALLPAPER="$HOME/Pictures/Wallpapers"

# Rotation interval
Interval=15m
This example changes wallpapers every 15 minutes. GNU sleep also accepts intervals such as 30s and 1h.

# Wallpaper categories

The script uses two filename keywords, one for each category. Example values:
```bash
Primary_Keyword="Primary"
Secondary_Keyword="Secondary"
```
Wallpapers can be named using a consistent convention:
*Primary_Forest_Landscape.jpg
*Primary_Mountain_Portrait.png
*Secondary_Abstract_Composition.jpeg
*Secondary_Digital_Illustration.png

Category matching is case-insensitive and searches for the configured keyword anywhere in the filename.

# Scheduled category
By default, Mangekyō uses the secondary category between 8:00 PM and 10:00 PM according to the system's local time. Outside this window, it uses the primary category.

The schedule can be adjusted in the main loop.

# Usage
From the project directory, run:
bash mangekyo.sh

Or grant executable permissions:
chmod +x mangekyo.sh

Then run:
./mangekyo.sh

The script runs continuously and rotates wallpapers at the configured interval.
Press Ctrl+C to stop it when running in the foreground.

# How It Works
1. Mangekyō searches the configured directory for image files matching each category keyword.
2. Matching images are stored in separate Bash arrays.
3. Both arrays are shuffled using the Fisher–Yates algorithm.
4. The system's local hour determines which category is active.
5. The next wallpaper is selected from that category's array.
6. ImageMagick calculates a representative color, and feh applies the wallpaper.
7. When a category's array is exhausted, the script reshuffles that array and resets its index.
8. The process repeats until stopped.

The image lists are loaded at startup. Restart the script to include newly added wallpaper files.

# Limitations and Future Plans
*Requires an X11-compatible wallpaper environment.
*Currently supports two categories.
*Category keywords and scheduling are configured in the script.
*Wallpaper collections are loaded at startup.
*Separate shuffle cycles can produce the same image consecutively at a cycle boundary.

Potential future improvements include Wayland/Hyprland compatibility, external configuration, and additional wallpaper-management options.

# Project Background
Mangekyō began as a personal desktop customization experiment and evolved through iterative Bash scripting, troubleshooting, and algorithm development.

The project demonstrates shell scripting, arrays, functions, filesystem operations, randomization algorithms, process control, and Linux desktop integration.

# Author
Created and maintained by Ichika137.

# License
License to be determined. Until a license is added, standard copyright restrictions apply.
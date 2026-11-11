#!/usr/bin/env bash
# ####################################万華鏡##########################################
### ############################### MANGEKYŌ #######################################

# Directory containing wallpapers
WALLPAPER="$HOME/Pictures/Wallpapers"

# Time Intervals in minutes
Interval=15m
 
# Keywords for categorizing Images
Primary_Keyword="Primary"
Secondary_Keyword="Secondary"

# Functions to gather Images based on keywords
Get_Image_Files() {
    local keyword="$1"
    find "$WALLPAPER" -type f \( -iname "*$keyword*.jpg" -o -iname "*$keyword*.jpeg" -o -iname "*$keyword*.png" \) -print0
}

# 2nd Function to Shuffle Array | Fisher-Yates Shuffle Algorithm
Shuffle_Array(){
   local -n Arr=$1
   local i Temporary j
   for ((i=${#Arr[@]}-1; i>0; i--)); do
        j=$(( $(od -An -N2 -i /dev/urandom) % (i+1) ))
        Temporary="${Arr[i]}"
        Arr[i]="${Arr[j]}"
        Arr[j]="$Temporary"
    done
}

# Launch the arrays
declare -a Primary_Images
declare -a Secondary_Images

# Fill the arrays
mapfile -d $'\0' Primary_Images < <(Get_Image_Files "$Primary_Keyword")
mapfile -d $'\0' Secondary_Images < <(Get_Image_Files "$Secondary_Keyword")

# Shuffle the Arrays After filling
Shuffle_Array Primary_Images
Shuffle_Array Secondary_Images

# Launch Counters
Primary_Index=0
Secondary_Index=0

# Main Loop
while true; do

    # Determine which keyword to use based on current time | Between 8 PM (20) - 10 PM (22)
    Current_Time=$(date +%H)
    if [ "$Current_Time" -ge 20 ] && [ $Current_Time -lt 22 ]; then 
        Category="Secondary"
        if [ $Secondary_Index -ge ${#Secondary_Images[@]} ]; then
            Shuffle_Array Secondary_Images
            Secondary_Index=0
        fi
        Selected_WallArt="${Secondary_Images[Secondary_Index]}"
        ((Secondary_Index++))
    else    
        Category="Primary"
        if [ $Primary_Index -ge ${#Primary_Images[@]} ]; then
            Shuffle_Array Primary_Images
            Primary_Index=0
        fi
        Selected_WallArt="${Primary_Images[Primary_Index]}"
        ((Primary_Index++))
    fi

    echo "Using $Category Image: $Selected_WallArt"

    # Set Dominant Color
    if [ -f "$Selected_WallArt" ]; then
        Dominant_Color=$(magick "$Selected_WallArt" -resize 1x1\! -format '#%[hex:u]' info:-)
        echo "Dominant Color: $Dominant_Color"

        # Setting Wallpaper
        feh --bg-max "$Selected_WallArt" --image-bg "$Dominant_Color"
    else
        echo "Error: Selected Image file does not exist: $Selected_WallArt"
    fi

    sleep $Interval
done
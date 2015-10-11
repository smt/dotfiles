#!/bin/sh
#
# .xinitrc
#
# Executed by startx (run your window manager from here)

# plz.
setxkbmap -layout dvorak

# Define function for easy setting of touchpad input device features.
# Expects two arguments:
# - String: property name
# - Integer: 1 or 0 (to enable/disable)
# (use `xinit list-props` to see a list of available device properties)
function set_touchpad_feature {
    # Get the numeric device ID
    touchpad_id=`xinput list "ETPS/2 Elantech Touchpad" | sed -n -e 's/.*id=\([0-9]\+\).*/\1/p'`

    # Get the numeric property ID for the property name, passed in first argument
    property_id=`xinput list-props $touchpad_id | sed 's/(\([0-9]\+\)):/\1/' | awk -v name="$1 [0-9]+" '$0 ~ name{ print $(NF-1) }'`

    # Set the device property to either 1 or 0, passed in second argument
    xinput set-prop $touchpad_id $property_id $2
}

# Enable touchpad tapping and natural scrolling
set_touchpad_feature 'Tapping Enabled' 1
set_touchpad_feature 'Natural Scrolling Enabled' 1

# restore the previous desktop
# sh ~/.fehbg
hsetroot -fill /home/tude/Downloads/6N0yS5m.jpg -blur 10 -brightness -0.2 -tint "#DDFFDD" &

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

sxhkd -m 1 &
exec bspwm

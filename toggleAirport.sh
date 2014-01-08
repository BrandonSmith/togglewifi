#!/bin/bash
# originally not mine... found somewhere on the interwebs

function set_airport {

    new_status=$1

    if [ $new_status = "On" ] ; then
        /usr/sbin/networksetup -setairportpower en0 on
        touch /var/tmp/prev_air_on
    else
        /usr/sbin/networksetup -setairportpower en0 off
        if [ -f "/var/tmp/prev_air_on" ]; then
            rm /var/tmp/prev_air_on
        fi
    fi
}

function notify {

    if [ -f "/opt/local/bin/terminal-notifier" ]; then
        /opt/local/bin/terminal-notifier -message "$1"
    else
        # checks whether growl is installed
        if [ -f "/usr/local/bin/growlnotify" ]; then
            /usr/local/bin/growlnotify -m "$1" -a "AirportUtility.app"
        fi
    fi
}

# set default values
prev_eth_status="Off"
prev_air_status="Off"

eth_status="Off"

# determine previous ethernet status
# if file prev_eth_on exists, ethernet was active last time we checked
if [ -f "/var/tmp/prev_eth_on" ]; then
    prev_eth_status="On"
fi

# determine same for AirPort status
# file is prev_air_on
if [ -f "/var/tmp/prev_air_on" ]; then
    prev_air_status="On"
fi

# check actual current ethernet status
if [ "`ifconfig | grep \"en5\"`" != "" ]; then 
    if [ "`ifconfig en5 | grep \"status: active\"`" != "" ]; then
        eth_status="On"
    fi
fi

# check actual current AirPort status
air_status=`/usr/sbin/networksetup -getairportpower en0 | awk '{ print $4 }'`

# if any change has occured, run external script
if [ "$prev_air_status" != "$air_status" ] || [ "$prev_eth_status" != "$eth_status" ]; then
    if [ -f "./statusChanged.sh" ]; then
        "./statusChanged.sh" "$eth_status" "$air_status" &
    fi
fi

# determine whether ethernet status changed
if [ "$prev_eth_status" != "$eth_status" ]; then
    if [ "$eth_status" = "On" ]; then
        set_airport "Off"
        notify "Wired network detected. Turning AirPort off."
    else
        set_airport "On"
        notify "No wired network detected. Turning AirPort on."
    fi
else
    # if ethernet did not change

    # check whether airport status changed... if so, it was manually don by user
    if [ "$prev_air_status" != "$air_status" ]; then
        set_airport $air_status

        if [ "$air_status" = "On" ]; then
            notify "AirPort manually turned on."
        else
            nofity "AirPort manually turned off."
        fi
    fi
fi

# update ethernet status
if [ "$eth_status" == "On" ]; then
    touch /var/tmp/prev_eth_on
else
    if [ -f "/var/tmp/prev_eth_on" ]; then
        rm /var/tmp/prev_eth_on
    fi
fi

exit 0


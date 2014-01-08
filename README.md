togglewifi
==========

This is a simple script that can be installed on Mac OSX to
automatically enable and disable Aiport (Wi-Fi) based on ethernet
connectivity.

Features:
* Runs as a OSX system service using launchctl
* Growl notification of enable and disable
* OSX 10.8+ notification if Growl is not present

Assumptions:
* Thunderbolt Ethernet interface is en5
* Aiport interface is en0

(Other Macbook Pro confgurations are typically en0 as ethernet and en1 as Airpot)

If these are different on your system, please edit `toggleAirport.sh` before installing. (If anybody knows
to make this discoverable via bash, please let me know.)

Installation
------------

[Download the latest zip](https://github.com/BrandonSmith/togglewifi/archive/master.zip) or clone the repo.

    

To install, use the Makefile:

    make install

If you do not have make installed:

    cp ./toggleAirport.sh /usr/local/bin/.
    chmod a+x /usr/local/bin/toggleAirport.sh
    cp ./com.16cards.toggleairport.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.16cards.toggleairport.plist
    launchctl start com.16cards.toggleairport
    
To uninstall:

    make uninstall

Notifications
-------------

`togglewifi` uses either Growl 2.0 or OS X Notification Center to display when certain actions have taken place such as:

* No wired network detected. Turning AirPort on.
* Wired network detected. Turning AirPort off.
* AirPort manually turned on.
* AirPort manually turned off.

In order to see these messages, you must either install [growlnotify](http://growl.info/downloads) or terminal-notifier.

terminal-notifier can be installed through MacPorts or as a gem:

    sudo port install terminal-notifier
    sudo gem install terminal-notifier

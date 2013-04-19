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
* Ethernet interface is en0
* Aiport interface is en1

Installation
------------

To install, use the Makefile:

    make install

To uninstall:

    make uninstall



all: install

install: script agent

uninstall: unagent unscript

script:
	echo "Installing script..."
	cp ./toggleAirport.sh /usr/local/bin/.
	chmod a+x /usr/local/bin/toggleAirport.sh

unscript:
	echo "Uninstalling script..."
	rm /usr/local/bin/toggleAirport.sh

agent:
	echo "Installing agent..."
	cp ./com.16cards.toggleairport.plist ~/Library/LaunchAgents/
	launchctl load ~/Library/LaunchAgents/com.16cards.toggleairport.plist
	launchctl start com.16cards.toggleairport

unagent:
	echo "Uninstalling agent..."
	launchctl unload ~/Library/LaunchAgents/com.16cards.toggleairport.plist
	rm ~/Library/LaunchAgents/com.16cards.toggleairport.plist


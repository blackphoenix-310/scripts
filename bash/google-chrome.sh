#!/bin/bash
echo
echo "Will now download and install Google-Chrome-Stable."
echo "Press enter to continue..."
read
cd /$HOME/$USER/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
dpkg -i google-chrome-*
echo "Installing Google Chrome. Press y when prompted..."
echo "Google Chrome installed..."
echo "Cleaning up packages..."
rm -v google-chrome-*
apt-get -y autoremove
echo "Install complete!"

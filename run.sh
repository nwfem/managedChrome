#!/bin/bash

CONFIG_VERSION=1.0

# Create temporary directory
mkdir -p .temp/root
cp com.google.Chrome.plist .temp/root/

# Create installer for management plist file
pkgbuild --quiet --root .temp/root --identifier com.google.Chrome.management --install-location /Library/Managed\ Preferences/ --version $CONFIG_VERSION .temp/management.pkg

# Download/mount chrome dmg
curl --progress-bar -o .temp/googlechrome.dmg "https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"
hdiutil attach -quiet .temp/googlechrome.dmg

# Print intro and version number
echo -e "\n$(tput bold)Copy version and SHA265 outputs below$(tput sgr0):"
CHROME_VERSION=$(defaults read /Volumes/Google\ Chrome/Google\ Chrome.app/Contents/Info.plist CFBundleShortVersionString)
echo "Version: $CHROME_VERSION"

# Build package containing Google Chrome
pkgbuild --quiet --component /Volumes/Google\ Chrome/Google\ Chrome.app --install-location /Applications --identifier com.google.Chrome .temp/chrome.pkg

# Unmount the disk image using the mount point
hdiutil detach -quiet "$(hdiutil info | grep -m 1 "Google Chrome" | awk '{print $1}')"

# Edit version numbers and
sed -e "s/\$chromeVersion/$CHROME_VERSION/g" -e "s/\$configVersion/$CONFIG_VERSION/g" Distribution.xml > .temp/Distribution

# Combine
productbuild --quiet --distribution .temp/Distribution --package-path .temp --resources ./Resources ./googlechrome.pkg

# Remove temporary directory
rm -rf .temp

# Print googlechrome.pkg SHA256
echo "SHA-265: $(shasum -a 256 googlechrome.pkg | awk '{print $1}')"

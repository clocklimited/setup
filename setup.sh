# Stop if something fails
set -e

# Install the latest stable nave the node.js environment switcher Node.js
sudo sh -c 'curl -fsSL https://raw.github.com/isaacs/nave/master/nave.sh > /usr/local/bin/nave && chmod ugo+x /usr/local/bin/nave'

# Install a global node.js
nave usemain stable

# Download and Install Command Line Tools for Xcode - https://developer.apple.com/downloads/download.action?path=Developer_Tools/command_line_tools_os_x_mountain_lion_for_xcode__april_2013/xcode462_cltools_10_86938259a.dmg
curl -O https://dl.dropboxusercontent.com/u/4119997/Setup/xcode462_cltools_10_86938259a.dmg && open xcode462_cltools_10_86938259a.dmg

# Install Xcode
# https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12

echo "Press enter once Command Line Tools for Xcode are installed"
read

# Install Brew
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

# Install MongoDB
brew install mongo

# Launch mongo on startup
ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents

# Start mongo now
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist

# Install ZeroMQ
brew install 0mq
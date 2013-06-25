# Stop if something fails
set -e

# /usr/local/bin doesn't exist on a fresh install
if [ ! -d "/usr/local/bin" ]; then
  sudo mkdir -p /usr/local/bin
fi

# Install the latest stable nave the node.js environment switcher Node.js
sudo sh -c 'curl -fsSL https://raw.github.com/isaacs/nave/master/nave.sh > /usr/local/bin/nave && chmod ugo+x /usr/local/bin/nave'

# Install a global node.js
sudo nave usemain stable

# Is xcode needed?
if [ -x "$(xcode-select --print-path)" ]; then
    echo Skipping xcode
else
  echo Installing Xcode CLI tools
  # Download and Install Command Line Tools for Xcode - https://developer.apple.com/downloads/download.action?path=Developer_Tools/command_line_tools_os_x_mountain_lion_for_xcode__april_2013/xcode462_cltools_10_86938259a.dmg
  curl -O https://dl.dropboxusercontent.com/u/4119997/Setup/xcode462_cltools_10_86938259a.dmg && open xcode462_cltools_10_86938259a.dmg

  # Install Xcode
  # https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12

  echo "Press enter once Command Line Tools for Xcode are installed"
  read
fi

# Accept the Xcode licence
xcodebuild -license

# Is brew needed?
if [ -x "$(which brew)" ]; then
  echo Skipping brew
else
  echo Installing brew
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

# Is MongoDB needed?
if [ -x "$(which mongo)" ]; then
  echo Skipping MongoDB
else
  echo Installing MongoDB
  brew install mongo

  if [ ! -d ~/Library/LaunchAgents ]; then
    mkdir -p ~/Library/LaunchAgents
  fi

  # Launch mongo on startup
  ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents

  # Start mongo now
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
fi

# Install ZeroMQ
brew install 0mq

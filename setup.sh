#!/bin/bash

set -o pipefail

ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_GREEN=$ESC_SEQ"32;01m"
ARROW="\xE2\x96\xB6"
SUCCESS="\xE2\x9C\x94 success"
FAILURE="\xE2\x9C\x96 failure"

me=$(whoami)

function install_xcode {
    echo -e $COL_GREEN"$ARROW "$COL_RESET"Installing xcode command line tools... "
    XCODE_SUCCESS=1

    xcode-select --install

    if [ "$?" != "0" ]
    then
        XCODE_SUCCESS=0
        echo -e $COL_RED"xcode might already be installed, if so, ignore this error"$COL_RESET
    else
        echo -e $COL_GREEN"xcode installed"$COL_RESET
    fi
}

function install_homebrew {
    HOMEBREW_SUCCESS=1

    # This fixes a permission issue if there are multiple users on the mac
    sudo chown -R $(whoami) $(brew --prefix)/*

    echo -e $COL_GREEN"$ARROW "$COL_RESET"Installing Homebrew... "
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    if [ "$?" != "0" ]
    then
        HOMEBREW_SUCCESS=0
        echo -e $COL_RED"could not install homebrew"$COL_RESET
    else
        echo -e $COL_GREEN"installed homebrew"$COL_RESET
    fi

    # Just to avoid a potential bug
    mkdir -p ~/Library/Caches/Homebrew/Formula

    brew doctor

    echo -e $COL_GREEN"$ARROW "$COL_RESET"Adding custom homebrew casks... "
    brew tap caskroom/cask && \
    brew tap caskroom/fonts && \
    brew tap caskroom/versions && \
    brew tap homebrew/core && \
    brew tap homebrew/services

    if [ "$?" != "0" ]
    then
        HOMEBREW_SUCCESS=0
        echo -e $COL_RED"brew tap failed"$COL_RESET
    else
        echo -e $COL_GREEN"successfully added custom homebrew casks"$COL_RESET
    fi

    echo -e $COL_GREEN"$ARROW "$COL_RESET"Updating, Upgrading and Cleaning Homebrew... "
    brew update && brew upgrade && brew cleanup && brew cask cleanup

    if [ "$?" != "0" ]
    then
        HOMEBREW_SUCCESS=0
        echo -e $COL_RED"could not update, upgrade or cleanup brew"$COL_RESET
    else
        echo -e $COL_GREEN"successfully cleaned brew"$COL_RESET
    fi
}

function install_apps_and_plugins {
    APPS_SUCCESS=1
    echo -e $COL_GREEN"$ARROW "$COL_RESET"Installing apps and plugins... "
    brew cask install bettertouchtool \
                      docker \
                      google-chrome \
                      iterm2 \
                      istat-menus \
                      postman \
                      qlcolorcode \
                      qlimagesize \
                      qlmarkdown \
                      qlstephen \
                      quicklook-json \
                      resolutionator \
                      shuttle \
                      spotify \
                      steam \
                      the-unarchiver \
                      visual-studio-code

    if [ "$?" != "0" ]
    then
        APPS_SUCCESS=0
        echo -e $COL_RED"error while installing apps and plugins"$COL_RESET
    else
        echo -e $COL_GREEN"successfully installed all apps and plugins"$COL_RESET
    fi
}

function install_nerd_fonts {
    FONTS_SUCCESS=1
    echo -e $COL_GREEN"$ARROW "$COL_RESET"Installing nerd fonts... "
    brew cask install font-anonymice-powerline \
                    font-consolas-for-powerline \
                    font-dejavu-sans-mono-for-powerline \
                    font-droid-sans-mono-for-powerline \
                    font-fira-code \
                    font-fira-mono \
                    font-fira-mono-for-powerline \
                    font-firacode-nerd-font \
                    font-firacode-nerd-font-mono \
                    font-hasklig \
                    font-hasklig-nerd-font \
                    font-hasklig-nerd-font-mono \
                    font-inconsolata-dz-for-powerline \
                    font-inconsolata-g-for-powerline \
                    font-iosevka \
                    font-liberation-mono-for-powerline \
                    font-menlo-for-powerline \
                    font-meslo-for-powerline \
                    font-monofur-for-powerline \
                    font-monoid \
                    font-noto-mono-for-powerline \
                    font-roboto \
                    font-roboto-mono-for-powerline \
                    font-source-code-pro-for-powerline \
                    font-ubuntu-mono-derivative-powerline \
                    font-ubuntumono-nerd-font \
                    font-ubuntumono-nerd-font-mono

    if [ "$?" != "0" ]
    then
        FONTS_SUCCESS=0
        echo -e $COL_RED"error while installing fonts"$COL_RESET
    else
        echo -e $COL_GREEN"successfully installed all fonts"$COL_RESET
    fi
}

function install_sys_tools {
    SYS_TOOLS_SUCCESS=1
    echo -e $COL_GREEN"$ARROW "$COL_RESET"Installing system tools, command line apps and libraries ... "
    brew install autoconf \
                 coreutils \
                 curl \
                 ffmpeg \
                 fish \
                 findutils \
                 grc \
                 git \
                 imagemagick \
                 jpeg \
                 libevent \
                 libmemcached \
                 libpng \
                 libtiff \
                 libtool \
                 libxml2 \
                 liblzf \
                 memcached \
                 mhash \
                 nmap \
                 openssl \
                 pkg-config \
                 python3 \
                 tree \
                 unzip

    if [ "$?" != "0" ]
    then
        SYS_TOOLS_SUCCESS=0
        echo -e $COL_RED"error while installing sys tools, cmd line apps and libraries"$COL_RESET
    else
        echo -e $COL_GREEN"successfully installed all system tools, command line apps and libraries"$COL_RESET
    fi
}

function brew_cleanup {
    echo -e $COL_GREEN"$ARROW "$COL_RESET"Updating, Upgrading and Cleaning Homebrew... "
    brew update && brew upgrade && brew cleanup && brew cask cleanup

    if [ "$?" != "0" ]
    then
        HOMEBREW_SUCCESS=0
        echo -e $COL_RED"could not update, upgrade or cleanup brew"$COL_RESET
    else
        echo -e $COL_GREEN"successfully cleaned brew"$COL_RESET
    fi
}

function install_utils {
    UTILS_SUCCESS=1
    echo -e $COL_GREEN"$ARROW "$COL_RESET"Installing git & docker custom scripts... "
    curl https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/utils/softcleandocker > /usr/local/bin/softcleandocker && chmod +x /usr/local/bin/softcleandocker
    curl https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/utils/cleandocker > /usr/local/bin/cleandocker && chmod +x /usr/local/bin/cleandocker
    curl https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/utils/killdocker > /usr/local/bin/killdocker && chmod +x /usr/local/bin/killdocker
    curl https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/utils/gcheck > /usr/local/bin/gcheck && chmod +x /usr/local/bin/gcheck

    if [ "$?" != "0" ]
    then
        UTILS_SUCCESS=0
        echo -e $COL_RED"could not download or install git and docker custom scripts"$COL_RESET
    else
        echo -e $COL_GREEN"successfully installed git and docker custom scripts"$COL_RESET
    fi
}

function install_fish {
    FISH_SUCCESS=1
    echo -e $COL_GREEN"$ARROW "$COL_RESET"Installing fish shell... "
    echo "/usr/local/bin/fish" >> /etc/shells
    chsh -s /usr/local/bin/fish

    if [ "$?" != "0" ]
    then
        FISH_SUCCESS=0
        echo -e $COL_RED"could not set fish as default shell"$COL_RESET
    else
        echo -e $COL_GREEN"successfully set fish as default shell"$COL_RESET
    fi

    echo -e $COL_GREEN"$ARROW "$COL_RESET"Installing OhMyFish... "
    curl -L https://get.oh-my.fish | fish

    if [ "$?" != "0" ]
    then
        FISH_SUCCESS=0
        echo -e $COL_RED"failed to install oh my fish"$COL_RESET
    else
        echo -e $COL_GREEN"successfully installed oh my fish"$COL_RESET
    fi

    echo -e $COL_GREEN"$ARROW "$COL_RESET"Installing OhMyFish plugins & themes... "
    omf install brew \
                cd \
                grc \
                osx \
                agnoster
    omf theme agnoster

    if [ "$?" != "0" ]
    then
        FISH_SUCCESS=0
        echo -e $COL_RED"failed to install custom packages and themes in fish"$COL_RESET
    else
        echo -e $COL_GREEN"successfully installed custom packages and set the agnoster theme"$COL_RESET
    fi

    echo -e $COL_GREEN"$ARROW "$COL_RESET"Configure fish shell... "
    mkdir -p ~/.config/fish/functions

    curl https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/fish/config.fish > ~/.config/fish/config.fish

    echo 'set PATH $PATH /usr/local/opt/curl/bin' >> ~/.config/fish/config.fish
    echo 'set PATH $PATH /usr/local/sbin' >> ~/.config/fish/config.fish
    echo 'set PATH $PATH /usr/local/bin' >> ~/.config/fish/config.fish
    echo 'set PATH $PATH /usr/sbin' >> ~/.config/fish/config.fish
    echo 'set PATH $PATH /usr/bin' >> ~/.config/fish/config.fish
    echo 'set PATH $PATH /sbin' >> ~/.config/fish/config.fish
    echo 'set PATH $PATH /bin' >> ~/.config/fish/config.fish
    echo "set -g default_user $me" >> ~/.config/fish/config.fish

    # Install grc configuration files
    mkdir -p /usr/local/share/grc
    curl -o /usr/local/share/grc/conf.diff https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.diff && \
    curl -o /usr/local/share/grc/conf.docker-machinels https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.docker-machinels && \
    curl -o /usr/local/share/grc/conf.dockerimages https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.dockerimages && \
    curl -o /usr/local/share/grc/conf.dockerinfo https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.dockerinfo && \
    curl -o /usr/local/share/grc/conf.dockernetwork https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.dockernetwork && \
    curl -o /usr/local/share/grc/conf.dockerps https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.dockerps && \
    curl -o /usr/local/share/grc/conf.dockerpull https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.dockerpull && \
    curl -o /usr/local/share/grc/conf.dockersearch https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.dockersearch && \
    curl -o /usr/local/share/grc/conf.dockerversion https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.dockerversion && \
    curl -o /usr/local/share/grc/conf.env https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.env && \
    curl -o /usr/local/share/grc/conf.gcc https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.gcc && \
    curl -o /usr/local/share/grc/conf.gotest https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.gotest && \
    curl -o /usr/local/share/grc/conf.ifconfig https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.ifconfig && \
    curl -o /usr/local/share/grc/conf.ip https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.ip && \
    curl -o /usr/local/share/grc/conf.ipaddr https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.ipaddr && \
    curl -o /usr/local/share/grc/conf.iproute https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.iproute && \
    curl -o /usr/local/share/grc/conf.iptables https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.iptables && \
    curl -o /usr/local/share/grc/conf.iwconfig https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.iwconfig && \
    curl -o /usr/local/share/grc/conf.jobs https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.jobs && \
    curl -o /usr/local/share/grc/conf.log https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.log && \
    curl -o /usr/local/share/grc/conf.lolcat https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.lolcat && \
    curl -o /usr/local/share/grc/conf.ls https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.ls && \
    curl -o /usr/local/share/grc/conf.netstat https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.netstat && \
    curl -o /usr/local/share/grc/conf.nmap https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.nmap && \
    curl -o /usr/local/share/grc/conf.ps https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.ps && \
    curl -o /usr/local/share/grc/conf.sql https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.sql && \
    curl -o /usr/local/share/grc/conf.stat https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.stat && \
    curl -o /usr/local/share/grc/conf.traceroute https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.traceroute && \
    curl -o /usr/local/share/grc/conf.uptime https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.uptime && \
    curl -o /usr/local/share/grc/conf.whois https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/grc/conf.whois


    if [ "$?" != "0" ]
    then
        FISH_SUCCESS=0
        echo -e $COL_RED"failed to configure fish shell"$COL_RESET
    else
        echo -e $COL_GREEN"successfully configured fish shell"$COL_RESET
    fi
}

function download_terminal_themes {
    ITERM_SUCCESS=1
    echo -e $COL_GREEN"$ARROW "$COL_RESET"Download iterm2 themes & color schemes... "
    curl -o ~/Downloads/iterm.zip -LOk https://github.com/mbadolato/iTerm2-Color-Schemes/archive/master.zip && \
    curl -o ~/Downloads/com.googlecode.iterm2.plist https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/iterm/com.googlecode.iterm2.plist && \
    curl -o ~/Downloads/UllaakutDark.itermcolors https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/iterm/UllaakutDark.itermcolors && \
    unzip ~/Downloads/iterm.zip -d ~/Downloads && rm -f ~/Downloads/iterm.zip && \
    mv ~/Downloads/iTerm2-Color-Schemes-master/schemes ~/Downloads/themes/ && rm -rf ~/Downloads/iTerm2-Color-Schemes-master

    if [ "$?" != "0" ]
    then
        ITERM_SUCCESS=0
        echo -e $COL_RED"could not download iterm themes & color schemes"$COL_RESET
    else
        echo -e $COL_GREEN"successfully downloaded iterm themes & color schemes"$COL_RESET
    fi
}

function download_bettertouchtool_presets {
    BTT_SUCCESS=1
    echo -e $COL_GREEN"$ARROW "$COL_RESET"Download BetterTouchTool presets... "
    curl -o ~/Downloads/SpotifyControls.bttpreset -LOk https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/btt/SpotifyControls.bttpreset && \
    curl -o ~/Downloads/Ullaakut.bttpreset -LOk https://raw.githubusercontent.com/Ullaakut/awesome-osx-setup/master/btt/Ullaakut.bttpreset && \

    if [ "$?" != "0" ]
    then
        BTT_SUCCESS=0
        echo -e $COL_RED"could not download BTT presets"$COL_RESET
    else
        echo -e $COL_GREEN"successfully downloaded BTT presets"$COL_RESET
    fi
}

function configure_git {
    GIT_SUCCESS=1
    echo -e $COL_GREEN"$ARROW "$COL_RESET"Configure git... "
    read -e -p "Enter your git username: " USERNAME
    read -e -p "Enter your git email address: " EMAIL
    git config --global user.name $USERNAME && \
    git config --global user.email $EMAIL && \
    git config --global core.ignorecase false && \
    git config --global core.editor "code --wait" && \
    git config --global pull.rebase true

    if [ "$?" != "0" ]
    then
        GIT_SUCCESS=0
        echo -e $COL_RED"could not configure git"$COL_RESET
    else
        echo -e $COL_GREEN"git configuration successful"$COL_RESET
    fi

    echo -e $COL_GREEN"$ARROW "$COL_RESET"Generate SSH key... "
    ssh-keygen -t rsa -b 4096 -C $EMAIL && \
    eval "$(ssh-agent -s)" && \
    ssh-add ~/.ssh/id_rsa && \
    pbcopy < ~/.ssh/id_rsa.pub

    if [ "$?" != "0" ]
    then
        GIT_SUCCESS=0
        echo -e $COL_RED"could not generate ssh key"$COL_RESET
    else
        echo -e $COL_GREEN"ssh key successfully generated"$COL_RESET
    fi
}

function configure_osx_defaults {
    echo -e $COL_GREEN"$ARROW "$COL_RESET"Configure OSX defaults... "
    # Expand "Save" and "Print" panels.
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

    # Use current directory as default search scope in Finder.
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Remove duplicate "Open With" options.
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

    # Show extensions in Finder.
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Show path in Finder.
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

    # Expand save panel by default.
    defaults write -g NSNavPanelExpandedStateForSaveMode -bool true && \
    defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

    # Disable creation of .DS_Store folders
    defaults write com.apple.desktopservices DSDontWriteNetworkStores true

    # Save locally by default.
    defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

    # Column view by default.
    defaults write com.apple.Finder FXPreferredViewStyle clmv

    # Allow selecting text in Quick Look.
    defaults write com.apple.finder QLEnableTextSelection -bool true

    # Use OSX print dialog in Chrome.
    defaults write com.google.Chrome DisablePrintPreview -bool true
    defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

    # Copy email addresses, not names, from Mail.
    defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

    # Quit Printer app when complete.
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Ignore Quarantine of unknown apps.
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Reboot to a clean slate.
    defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

    # Enable "Tap to Click".
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    # Invert scrolling direction.
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

    # Open Finder at "~/" directory.
    defaults write com.apple.finder NewWindowTarget -string "PfLo"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

    # Don't create temporary files to network mounted drives.
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # Unhide "~/Library" folder.
    chflags nohidden ~/Library

    # Disable Time Machine prompt for every disk.
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    # Configure Activity Monitor to always open a window, sorted by the most CPU intensive tasks.
    defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
    defaults write com.apple.ActivityMonitor ShowCategory -int 0
    defaults write com.apple.ActivityMonitor SortColumn -string "cpUUsage"
    defaults write com.apple.ActivityMonitor SortDirection -int 0

    echo -e $COL_GREEN"done"$COL_RESET
}

echo -e $COL_GREEN"OSX setup initiated"$COL_RESET
echo -e "This script can setup the following:"
echo -e "\t- Install xcode command line tools (necessary for compiling most languages)"
echo -e "\t- Install Homebrew"
echo -e "\t- Install basic apps and plugins"
echo -e "\t- Install nerd-fonts (powerline + many symbols)"
echo -e "\t- Install system tools, command line tools & libraries"
echo -e "\t- Install docker and git custom scripts"
echo -e "\t- Install and configure fish shell"
echo -e "\t- Download iterm2 themes"
echo -e "\t- Download BetterTouchTool presets"
echo -e "\t- Configure git"
echo -e "\t- Generate SSH keys"
echo -e "\t- Configure OSX hidden settings"
read -e -p "Would you like for the script to execute all of the above? [y/N]: " EXECUTE_ALL

if [ "$EXECUTE_ALL" == "y" ]
then
    install_xcode
    install_homebrew
    install_apps_and_plugins
    install_nerd_fonts
    install_sys_tools
    brew_cleanup
    install_utils
    install_fish
    download_terminal_themes
    download_bettertouchtool_presets
    configure_git
    configure_osx_defaults
    echo "The iterm2 and BetterTouchTool configuration files can be found in your ~/Downloads folder and your public SSH key is in your clipboard, ready to be uploaded to your source control"
else
    read -e -p "Would you like to install xcode command line tools? [y/N]: " EXECUTE_XCODE
    read -e -p "Would you like to install homebrew? [y/N]: " EXECUTE_HOMEBREW
    read -e -p "Would you like to install apps and plugins? [y/N]: " EXECUTE_APPS
    read -e -p "Would you like to install nerd fonts? [y/N]: " EXECUTE_NERD_FONTS
    read -e -p "Would you like to install system and command line tools? [y/N]: " EXECUTE_SYS_TOOLS
    read -e -p "Would you like to install git and docker custom scripts? [y/N]: " EXECUTE_UTILS
    read -e -p "Would you like to install fish shell? [y/N]: " EXECUTE_FISH
    read -e -p "Would you like to download iterm2 themes & color schemes? [y/N]: " EXECUTE_ITERM
    read -e -p "Would you like to download BetterTouchTool presets? [y/N]: " EXECUTE_BTT
    read -e -p "Would you like to configure git & generate ssh keys? [y/N]: " EXECUTE_GIT
    read -e -p "Would you like to configure OSX defaults? [y/N]: " EXECUTE_OSX

    if [ "$EXECUTE_XCODE" == "y" ]
    then
        install_xcode
    fi

    if [ "$EXECUTE_HOMEBREW" == "y" ]
    then
        install_homebrew
    fi

    if [ "$EXECUTE_APPS" == "y" ]
    then
        install_apps_and_plugins
    fi

    if [ "$EXECUTE_NERD_FONTS" == "y" ]
    then
        install_nerd_fonts
    fi

    if [ "$EXECUTE_SYS_TOOLS" == "y" ]
    then
        install_sys_tools
    fi

    if [ "$EXECUTE_HOMEBREW" == "y" ] || [ "$EXECUTE_APPS" == "y" ] || [ "$EXECUTE_NERD_FONTS" == "y" ] || [ "$EXECUTE_SYS_TOOLS" == "y" ]
    then
        brew_cleanup
    fi

    if [ "$EXECUTE_UTILS" == "y" ]
    then
        install_utils
    fi

    if [ "$EXECUTE_FISH" == "y" ]
    then
        install_fish
    fi

    if [ "$EXECUTE_ITERM" == "y" ]
    then
        download_terminal_themes
    fi

    if [ "$EXECUTE_BTT" == "y" ]
    then
        download_bettertouchtool_presets
    fi

    if [ "$EXECUTE_GIT" == "y" ]
    then
        configure_git
    fi

    if [ "$EXECUTE_OSX" == "y" ]
    then
        configure_osx_defaults
    fi
fi

echo -e "\n"$COL_GREEN"$ARROW"$COL_RESET" OSX setup over. Summary:\n"

if [ "$EXECUTE_BTT" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "The BetterTouchTool configuration files can be found in your "$COL_GREEN" ~/Downloads "$COL_RESET" folder"
fi

if [ "$EXECUTE_ITERM" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "The iterm2 configuration files can be found in your "$COL_GREEN" ~/Downloads "$COL_RESET" folder"
fi

if [ "$EXECUTE_GIT" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "Your public "$COL_GREEN" SSH key is in your clipboard "$COL_RESET", ready to be uploaded to your source control"
fi

if [ "$XCODE_SUCCESS" == "1" ] && ([ "$EXECUTE_XCODE" == "y" ] || [ "$EXECUTE_ALL" == "y" ])
then
    echo -e "\t[install xcode command line tools]\t\t\t"$COL_GREEN"$SUCCESS" $COL_RESET
elif [ "$EXECUTE_XCODE" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "\t[install xcode command line tools]\t\t\t"$COL_RED"$FAILURE" $COL_RESET
fi

if [ "$HOMEBREW_SUCCESS" == "1" ] && ([ "$EXECUTE_HOMEBREW" == "y" ] || [ "$EXECUTE_ALL" == "y" ])
then
    echo -e "\t[install & configure homebrew]\t\t\t\t"$COL_GREEN"$SUCCESS" $COL_RESET
elif [ "$EXECUTE_HOMEBREW" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "\t[install & configure homebrew]\t\t\t\t"$COL_RED"$FAILURE" $COL_RESET
fi

if [ "$APPS_SUCCESS" == "1" ] && ([ "$EXECUTE_APPS" == "y" ] || [ "$EXECUTE_ALL" == "y" ])
then
    echo -e "\t[install apps & plugins]\t\t\t\t"$COL_GREEN"$SUCCESS" $COL_RESET
elif [ "$EXECUTE_APPS" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "\t[install apps & plugins]\t\t\t\t"$COL_RED"$FAILURE" $COL_RESET
fi

if [ "$FONTS_SUCCESS" == "1" ] && ([ "$EXECUTE_NERD_FONTS" == "y" ] || [ "$EXECUTE_ALL" == "y" ])
then
    echo -e "\t[install nerd fonts]\t\t\t\t\t"$COL_GREEN"$SUCCESS" $COL_RESET
elif [ "$EXECUTE_NERD_FONTS" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "\t[install nerd fonts]\t\t\t\t\t"$COL_RED"$FAILURE" $COL_RESET
fi

if [ "$SYS_TOOLS_SUCCESS" == "1" ] && ([ "$EXECUTE_SYS_TOOLS" == "y" ] || [ "$EXECUTE_ALL" == "y" ])
then
    echo -e "\t[install system tools, command line apps & libraries]\t"$COL_GREEN"$SUCCESS" $COL_RESET
elif [ "$EXECUTE_SYS_TOOLS" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "\t[install system tools, command line apps & libraries]\t"$COL_RED"$FAILURE" $COL_RESET
fi

if [ "$UTILS_SUCCESS" == "1" ] && ([ "$EXECUTE_UTILS" == "y" ] || [ "$EXECUTE_ALL" == "y" ])
then
    echo -e "\t[install git/docker custom scripts]\t\t\t"$COL_GREEN"$SUCCESS" $COL_RESET
elif [ "$EXECUTE_UTILS" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "\t[install git/docker custom scripts]\t\t\t"$COL_RED"$FAILURE" $COL_RESET
fi

if [ "$FISH_SUCCESS" == "1" ] && ([ "$EXECUTE_FISH" == "y" ] || [ "$EXECUTE_ALL" == "y" ])
then
    echo -e "\t[install fish, OhMyFish, themes and plugins]\t\t"$COL_GREEN"$SUCCESS" $COL_RESET
elif [ "$EXECUTE_FISH" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "\t[install fish, OhMyFish, themes and plugins]\t\t"$COL_RED"$FAILURE" $COL_RESET
fi

if [ "$ITERM_SUCCESS" == "1" ] && ([ "$EXECUTE_ITERM" == "y" ] || [ "$EXECUTE_ALL" == "y" ])
then
    echo -e "\t[download iterm2 themes and color schemes]\t\t"$COL_GREEN"$SUCCESS" $COL_RESET
elif [ "$EXECUTE_ITERM" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "\t[download iterm2 themes and color schemes]\t\t"$COL_RED"$FAILURE" $COL_RESET
fi

if [ "$BTT_SUCCESS" == "1" ] && ([ "$EXECUTE_BTT" == "y" ] || [ "$EXECUTE_ALL" == "y" ])
then
    echo -e "\t[download BetterTouchTool presets]\t\t\t"$COL_GREEN"$SUCCESS" $COL_RESET
elif [ "$EXECUTE_BTT" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "\t[download BetterTouchTool presets]\t\t\t"$COL_RED"$FAILURE" $COL_RESET
fi

if [ "$GIT_SUCCESS" == "1" ] && ([ "$EXECUTE_GIT" == "y" ] || [ "$EXECUTE_ALL" == "y" ])
then
    echo -e "\t[configure git & generate ssh keys]\t\t\t"$COL_GREEN"$SUCCESS" $COL_RESET
elif [ "$EXECUTE_GIT" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "\t[configure git & generate ssh keys]\t\t\t"$COL_RED"$FAILURE" $COL_RESET
fi

if [ "$EXECUTE_OSX" == "y" ] || [ "$EXECUTE_ALL" == "y" ]
then
    echo -e "\t[configure OSX defaults]\t\t\t\t"$COL_GREEN"$SUCCESS" $COL_RESET
fi

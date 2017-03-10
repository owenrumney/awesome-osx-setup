# New Environment Bootstrap

## Table of content

- [Ubuntu](#ubuntu)
- [Kali Linux](#kali-linux)
- [OSX](#osx)
- [Windows](#windows)
- [Android](#android)
- [Google Chrome](#google-chrome)

## Ubuntu

1. [Download Ubuntu image](http://releases.ubuntu.com/16.04.2/ubuntu-16.04.2-desktop-amd64.iso).
2. Install packets
  1. `sudo apt install -y docker docker-compose`
  2. `sudo apt install -y emacs atom`
  3. `sudo apt install -y cmake colormake`
  4. `sudo apt install -y clang clang-format cppcheck g++ gcc gcc-5 valgrind`
  5. `sudo apt install -y colordiff`
  6. `sudo apt install -y htop dstat iptables wireshark netstat iptlist wget ngrep`
  7. `sudo apt install -y fish`
  8. `sudo apt install -y ffmpeg vlc`
  9. `sudo apt install -y golang`
  10. `sudo apt install -y grc`
  11. `sudo apt install -y libgstreamer1.5-dev`
  12. `sudo apt install -y unity-tweak-tool numix-gtk-theme`
  13. `sudo apt install -y libglib2.0-dev`
  14. `sudo apt install -y zip unzip`
  15. `curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher`
  16. `fisher docker-completion`
  17. `sudo apt install -y nodejs npm`
  18. `npm install -g n bower`
3. `curl 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' -H 'dnt: 1' -H 'accept-encoding: gzip, deflate, sdch, br' -H 'upgrade-insecure-requests: 1' -H 'authority: dl.google.com' --compressed`
4. `git clone https://github,con/syl20bnr/spacemacs ~/.emacs.d`
5. `wget https://raw.githubusercontent.com/Ullaakut/new-environment-bootstrap/master/config.fish -P ~/.config/fish/`
6. `wget https://raw.githubusercontent.com/Ullaakut/new-environment-bootstrap/master/.spacemacs -P ~/`
7. `unity-tweak-tool`
  1. Reduce launcher icon size to 26
  2. Disable background blur & suggestions of the research panel for performance
  3. Change date format to show seconds for quick latency testing
  4. Disable windows animations for performance
  5. Enable workspace switcher
  6. Change theme to Numix daily and icons to Numix Circle
  7. Change Monospace default font to _Roboto Medium For Powerline Medium 9pt_
8. Terminal properties
  1. Disable scrollback limitation
  2. Enable transparency
9. Atom plugins
  1. `autocomplete-go`
  2. `builder-go`
  3. `clang-format`
  4. `go-config`
  5. `go-debug`
  6. `go-get`
  7. `go-plus`
  8. `godoc`
  9. `gofmt`
  10. `gometalinter-linter`
  11. `gorename`
  12. `language-api-blueprint`
  13. `language-cmake`
  14. `language-docker`
  15. `linter`
  16. `minimap`
  17. `minimap-find-and-replace`
  18. `multi-cursor`
  19. `navigator-godef`
  20. `tester-go`
10. Create launcher shortcut to Postman chrome plugin
  1. Import Postman collections and utils
  2. Switch to dark theme
11. Activate guest account
12. If on a Mac, install camera driver
13. Install packages in Spacemacs
  1. `fish-mode`
  2. `google-translate`
  3. `json-mode`
  4. `lorem-ipsum`
  5. `markdown-mode`
  6. `multiple-cursors`
  7. `nginx-mode`
  8. `powerline`
14. `mkdir -p ~/Work/go`

## Kali Linux

**I have to check which packages are already installed by default before committing this.**

1. `sudo apt-get install -y fish`
2. `sudo apt-get install -y wget && wget https://raw.githubusercontent.com/Ullaakut/new-environment-bootstrap/master/config.fish -P ~/.config/fish/config.fish`
3. `sudo apt-get install -y python3`
4. `sudo apt-get install -y dstat`
5. `sudo apt-get install -y netstat`
6. `sudo apt-get install -y wireshark`
7. `sudo apt-get install -y iptlist`
8. `sudo apt-get install -y ngrep`
9. Install tor browser + firefox
10. `sudo apt-get install -y emacs && git clone https://github,con/syl20bnr/spacemacs ~/.emacs.d`
11. Edit `/etc/proxychains.conf`
  1. Comment strict_chain
  2. Uncomment dynamic_chain
  3. Add multiple socks5 proxies
  4. Test it by starting tor service and launching `proxychains firefox www.duckduckgo.com`
  5. Go on dnsleaktest.com just to make sure
12. Edit `/etc/dhcp/dhclient.conf`
  1. Uncomment `prepend domain-name-servers` line
  2. Replace `prepend domain-name-servers 127.0.0.1`'s value with OpenDNS
  3. Make sure it's okay by catting `/etc/resolv.conf`
13. Make sure reaver is installed
14. `sudo apt-get install -y sslstrip`
15. `sudo apt-get install -y dsniff`
16. `sudo apt-get install -y arpspoof`
18. `sudo apt-get install -y setoolkit`
19. `sudo apt-get install -y nslookup`
20. `sudo apt-get install -y mysql-client`

## OSX
Do not install latest OSX version, install OSX El Captain 10.11.x

1. Google Chrome
2. VMWare Fusion
  1. Setup Ubuntu VM for dev
  2. Setup Kali VM for pentesting
3. istat
4. VLC
5. Microsoft Office
6. Spotify
7. Skype
8. Stremio
9. TeamViewer
10. Disk Inventory X
11. Adobe Photoshop
12. Spectacle
13. Transmission
14. f.lux
15. Settings
  1. Hot corner to lock
  2. Reduce keypress for accents as much as possible
  3. Put dock on the right
  4. Disable dashboard
  5. Reverse scroll
  6. Make trackpad as easy as possible
  7. Backup

## Windows

Download from Epitech Intra & use student license.

1. Disable Cortana
2. Disable microphone
3. Disable camera
4. Disable XBOX app
5. Install Google Chrome
6. Install MBAM
7. Install CCleaner
8. Install Microsoft Office
9. Install Adobe Photoshop
10. Install Steam & Origin
11. Install VLC
12. Install Spotify
13. Install Stremio
14. Install TransmissionQt
15. Install WinDirStat
16. Install FileZilla
17. Install VMWare Workstation
  1. Setup Ubuntu VM for dev
  2. Setup Kali VM for pentesting
18. Install PuTTY
19. Install Atom
  1. `autocomplete-go`
  2. `builder-go`
  3. `clang-format`
  4. `go-config`
  5. `go-debug`
  6. `go-get`
  7. `go-plus`
  8. `godoc`
  9. `gofmt`
  10. `gometalinter-linter`
  11. `gorename`
  12. `language-api-blueprint`
  13. `language-cmake`
  14. `language-docker`
  15. `linter`
  16. `minimap`
  17. `minimap-find-and-replace`
  18. `multi-cursor`
  19. `navigator-godef`
  20. `tester-go`
20. Install f.lux
21. Settings
  1. Activate two finger scroll
  2. Reverse scroll
  3. Add french input language
  4. Disable as much startup services as possible
  5. Disable useless services

## Android

1. 9gag
2. Adobe Fill & Sign
3. Airbnb
4. Amazon app
5. Excel
6. Facebook
7. Instagram
8. Google Keep
9. LinkedIn
10. Messenger
11. Network Monitor
12. PeopleHR
13. PowerPoint
14. QRCodeReader
15. Reddit app
16. SensCritique
17. Sheets
18. Skype
19. Slack
20. Sleep
21. Snapchat
22. Spotify
23. Swiftkey
24. TeamViewer
25. Google Translate
26. Twitter
27. VLC
28. SNCF
29. Word
30. JeFit
31. Signal
32. Udemy
33. Stremio
34. Meetup
35. Impraise
36. ZenUI / Min Icon Pack

## Google Chrome

1. Stylish
2. Dark reader
3. AdBlock
4. HTTPS Everywhere
5. Postman
6. Social Fixer
7. Video Blocker

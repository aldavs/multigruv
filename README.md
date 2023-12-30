# multigruv
## about
A configurable, minimal SDDM theme with gruvbox defaults
## dependencies
- [sddm](https://github.com/sddm/sddm)
## installation
1. `git clone https://github.com/aldavs/multigruv.git && sudo chown -R root:root multigruv/`
2. `sudo mv multigruv/ /usr/share/sddm/themes/`
3. `sudo mkdir /etc/sddm.conf.d/ && sudo printf '[Theme]\nCurrent = multigruv' > /etc/sddm.conf.d/theme.conf`

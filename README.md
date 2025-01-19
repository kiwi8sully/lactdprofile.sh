A script to be called from the steam command line that changes power profiles on AMD graphics cards via the lactd api. ref: https://github.com/ilya-zlobintsev/LACT

## Requires
https://github.com/ilya-zlobintsev/LACT
ncat

### Install 

1. Copy Lactd_profile.sh and gamemode_end.sh to your /home/$USER/bin/ folder.

2. Edit /etc/gamemode.ini to point to gamemode_end.sh

```
end=$HOME/bin/gamemode_end.sh
```

3. Edit the game command line ...[Steam]>[Game]>[Properties]>[General]>[Launch Options]

```
LACTD_PROFILE="3D Games" GAMEMODERUNEXEC="$HOME/bin/lactd_profile.sh" gamemoderun %command%
```
where "3D Games" is the name of a lactd-gui profile.


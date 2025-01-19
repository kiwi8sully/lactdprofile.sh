A script to be called from the steam command line that changes power profiles on AMD graphics cards via the lactd api. https://github.com/ilya-zlobintsev/LACT

## Requires.
- https://github.com/ilya-zlobintsev/LACT
- ncat
- gamemode (optional but recommended)

### Install.

- Copy Lactd_profile.sh and gamemode_end.sh to your /home/$USER/bin/ folder.

- Edit /etc/gamemode.ini to point to gamemode_end.sh

```
end=$HOME/bin/gamemode_end.sh
```

- Edit the game command line ...[Steam]>[Game]>[Properties]>[General]>[Launch Options]

```
LACTD_PROFILE="3D Games" GAMEMODERUNEXEC="$HOME/bin/lactd_profile.sh" gamemoderun %command%
```
where "3D Games" is the name of a lact-gui profile.

### Command line.

For command line usage on a headless setup you may find the comments and lactd function in lactd_profile.sh usefull or have a look at the [wiki](https://github.com/kiwi8sully/lactdprofile.sh/wiki).

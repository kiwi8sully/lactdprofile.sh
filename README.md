A script to be called from the steam command line that changes power profiles on AMD graphics cards via the lactd api. ref: https://github.com/ilya-zlobintsev/LACT

[Steam]>[Game]>[Properties]>[General]>[Launch Options]

```
LACTD_PROFILE=1 GAMEMODERUNEXEC="$HOME/bin/lactd_profile.sh" gamemoderun %command%
```

/etc/gamemode.ini should be edited to point to gamemode_end.sh

```
end=$HOME/bin/gamemode_end.sh
```

if required to return the power profile to BOOTUP_DEFAULT [0] or POWER_SAVING [2] once the game has finished edit the line in gamemode_end.sh from

```
set_power_profile_mode auto
```
    to
```
set_power_profile_mode 0
```
    or
```
set_power_profile_mode 2
```

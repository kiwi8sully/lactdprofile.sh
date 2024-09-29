A script to be called from the steam command line that changes power profiles on AMD graphics cards via the lactd api. ref: https://github.com/ilya-zlobintsev/LACT

[Steam]>[Game]>[Properties]>[General]>[Launch Options]

```
LACTD_PROFILE=1 GAMEMODERUNEXEC="$HOME/bin/lactd_profile.sh" gamemoderun %command%
```

/etc/gamemode.ini should be edited to point to gamemode_end.sh

```
end=$HOME/bin/gamemode_end.sh
```


.RECIPEPREFIX = >
.PHONY: install check sync

install:
> ./install.sh

check:
> bin/dotcheck

sync:
> bin/dotsync "$(m)"

.PHONY: bootstrap
bootstrap:
> ./bootstrap.sh

.PHONY: pull
pull:
> bin/dotpull

.PHONY: zig sublime
zig:
> bash tools/zig.sh
sublime:
> bash tools/sublime.sh

.PHONY: sublime-zig
sublime-zig:
> bash tools/sublime-zig.sh

.PHONY: mechvibes
mechvibes:
> bash tools/mechvibes.sh

.PHONY: wallpaper
wallpaper:
> bash tools/wallpaper.sh

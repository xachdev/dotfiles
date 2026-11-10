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


.PHONY: wallpaper
wallpaper:
> bash tools/wallpaper.sh

.PHONY: lint
lint:
> shellcheck install.sh bootstrap.sh bin/* hooks/pre-commit tools/*.sh

.PHONY: backup
backup:
> bash tools/backup.sh $(d)

.PHONY: update
update:
> bin/dotupdate

.PHONY: obsidian
obsidian:
> bash tools/obsidian.sh

.PHONY: obsidian-appimage
obsidian-appimage:
> bash tools/obsidian-appimage.sh

.PHONY: obs-save
obs-save:
> bash tools/obs-save.sh



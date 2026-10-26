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

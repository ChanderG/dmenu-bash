DESTDIR ?= /etc/profile.d/

install:
	# 755 is default
	install -D -m 755 dmenu-utils.sh "$(DESTDIR)"/dmenu-utils.sh

uninstall:
	rm -f "$(DESTDIR)"/dmenu-utils.sh

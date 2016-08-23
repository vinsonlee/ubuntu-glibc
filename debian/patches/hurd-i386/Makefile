all:
	(cd /usr/src/hurd/glibc ; git branch | grep -e "  t/" | tr -d ' ' | tr / - | sed -e 's/^t-/tg-/' | sed -e 's/$$/.diff/' ) | sort | tee TODO.tg
	ls tg-* | sort | tee DONE.tg

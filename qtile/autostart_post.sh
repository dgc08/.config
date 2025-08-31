#!/usr/bin/env sh

/usr/bin/qtile/env/bin/qtile run-cmd -g 1 brave-browser --pasword-store=basic &
/usr/bin/qtile/env/bin/qtile run-cmd -g u easyeffects &
redshift-gtk -c .config/redshift.conf &

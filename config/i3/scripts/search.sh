#!/bin/sh

# brave https://duckduckgo.com/?\q=$(echo "" | dmenu -fn 'DejaVu Sans Mono Nerd Font:size=12' -nb '#004D40' -sb '#004D40' -i -p "Search web:")

q=$(echo "" | dmenu -fn 'DejaVu Sans Mono Nerd Font:size=12' -nb '#004D40' -sb '#004D40' -i -p "Search web:")
echo dusan je $q
if [ -z $q ]; then
    exit 0
elif [ $q == "mondo" ]; then
    brave www.mondo.rs
elif [ $q == "mf" ]; then
    brave www.github.com/mainflux/mainflux
elif [ $q == "fb" ]; then
    brave www.facebook.com
elif [ $q == "wa" ]; then
    brave https://web.whatsapp.com
else
    # URL-encode.
    q=$(echo $q | sed "s/ /+/g; s/\%/\%25/g")
    brave https://duckduckgo.com/?q=$q
fi

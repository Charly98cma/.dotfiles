#!/run/current-system/sw/bin/bash

CMD=$(nmcli con show --active | grep -i vpn | awk '{print $1, $(NF-3)}');
if [[ -z $CMD ]]; then printf '%s' "%{F#FF5555}󱙱 Down%{F-}"; else printf '%s' "󰌾 $CMD"; fi

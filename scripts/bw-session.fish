#!/usr/bin/env fish
# Bitwarden CLI wrapper with session key and wl-copy

mkdir -p /home/jan/.config/bitwarden

set i true

while $i
   set sessionkey (cat /home/jan/.config/bitwarden/session 2>/dev/null)
   set j (bw $argv --session $sessionkey)

   if test $status -eq 1
      bw unlock --raw > /home/jan/.config/bitwarden/session
   else

      # Sync from time to time
      set lastsync (date --date=(bw status | jq -r '.lastSync') +%s)
      if test (math $lastsync + 200000) -lt (date +%s)
         bw sync --session $sessionkey
      end
      # END Sync

      printf $j | wl-copy -o
      echo $j
      set i false
   end
end

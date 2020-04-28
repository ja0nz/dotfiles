#!/usr/bin/env fish
mkdir -p /home/jan/.config/bitwarden

set i true

while $i
   set j (bw get $argv[1] $argv[2] --session (cat /home/jan/.config/bitwarden/session) 2> /dev/null)

   if test $status -eq 1
      bw unlock --raw > /home/jan/.config/bitwarden/session
   else
      printf $j
      set i false
   end
end

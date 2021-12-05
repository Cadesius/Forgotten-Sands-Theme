#!/bin/sh

# if ps -C cmus > /dev/null; then

status=$(echo | cmus-remote -Q | grep status | sed 's/status //')
playing=$(echo playing)
paused=$(echo paused)
stopped=$(echo stopped)
albumartist=$(cmus-remote -Q | 
    grep "albumartist " | 
    sed -e 's/tag albumartist //' | 
    awk '{gsub("tag albumartist ", "");print}')


# case $status in
#     playing)
#         artist=`cmus-remote -Q | 
#         grep --text '^tag artist' | 
#         sed '/^tag artistsort/d' | 
#         awk '{gsub("tag artist ", "");print}'`
#         title=`cmus-remote -Q  | 
#         grep --text '^tag title' | 
#         sed -e 's/tag title //' |
#         awk '{gsub("tag title ", "");print}'`
#         echo "𒇥  $artist - $title"
#         ;;
#     paused)
#         echo "𒆹 Paused"
#         ;;
#     *)
#         echo "𒆹 Stopped"
#         ;;
# esac

if [ "$status" == "$playing" ]; then
    artist=`cmus-remote -Q | 
    grep --text '^tag artist' | 
    sed '/^tag artistsort/d' | 
    awk '{gsub("tag artist ", "");print}'`
    album=`cmus-remote -Q | 
    grep "album " | 
    sed -e 's/tag album //' | 
    awk '{gsub("tag album ", "");print}'`
    title=`cmus-remote -Q  | 
    grep --text '^tag title' | 
    sed -e 's/tag title //' |
    awk '{gsub("tag title ", "");print}'`
    echo "𒇥  $title - $album ($artist)"
elif [ "$status" == "$paused" ]; then
    echo "𒆹 Paused"
elif [ "$status" == "$stopped" ]; then
    echo "𒆸 Stopped"
else
    echo ""
fi

echo "$albumartist"

echo "$status"
echo "$playing"
echo "$paused"
URL='https://www.google.com/search?q='

QUERY=$(echo "" | rofi -dmenu -i -p  "Google" -theme-str 'window {height: 5%;}'); 

if [ -n "$QUERY" ]; then
  xdg-open "${URL}${QUERY}" 2> /dev/null
fi



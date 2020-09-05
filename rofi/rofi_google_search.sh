URL='https://www.google.com/search?q='
PROMPT="Google:"

QUERY=$(echo "" | rofi -dmenu -i -p  ${PROMPT} -theme-str 'window {height: 5%;}'); 

if [ -n "$QUERY" ]; then
  xdg-open "${URL}${QUERY}" 2> /dev/null
fi

#!/bin/sh

APPSUPPORT="${HOME}/Library/Application Support"
THEMES="
BetterDiscord/themes
dorion/themes
legcord/themes
"


SASS=$( which sass 2>/dev/null )
if [ -z "$SASS" ]; then
  echo "sass compiler not found.  Install with 'brew install sass/sass/sass'."
  exit 1
fi

echo "Building compact-discord.theme.css..."
cat <<_EOF >compact-discord.theme.css
/**
 * @name Compact Discord
 * @author Albert Portnoy
 * @version $( git describe --abbrev=0 )
 * @description Collapse the member and channel lists on small screens to save space. 
 * @source https://github.com/asportnoy/compact-discord
*/
_EOF

sass -q src/main.scss >>compact-discord.theme.css

if [ $? -gt 0 ]; then
  echo "Failed!"
  exit 1
fi
echo "Success!"

# Install themes
for dir in ${THEMES}
do
  [ -z "${dir}" ] && continue
  if [ -d "${APPSUPPORT}/${dir}" ]; then
    echo "Installing to ${dir}/compact-discord.theme.css"
    cp -p compact-discord.theme.css "${APPSUPPORT}/${dir}/"
  fi
done

#!/bin/bash
#=============================HEADER=================================|
#AUTOR
# Jefferson 'slackjeff' rocha <root@slackjeff.com.br
#
# MY DOMESTIC ALTERNATIVE OF IMGUR
#====================================================================|

# SERVER HERE, for using rsync.
SERVER='slackjeff@slackjeff.com.br:public_html/fuckgur'

# Website
WWW='http://slackjeff.com.br'

# Main directory
if [[ ! -d "${HOME}/fuckgur" ]]; then
    mkdir -v "${HOME}/fuckgur"
fi

read -ep "Local Image: " directory_image
if [[ -e "$directory_image" ]]; then
    new_name="$(head /dev/urandom | tr -dc "[:alnum:]" | head -c "8"; echo)"
    cp -v "$directory_image" "${HOME}/fuckgur/${new_name}"
else
    echo "Image dont exist"
    exit 1
fi

# Send to server
if rsync -dvh "${HOME}/fuckgur/" "$SERVER"; then
    echo "Delete temp directory in your home."
    rm -vr "${HOME}/fuckgur/"
    echo -e "\nYour image ON: ${WWW}/fuckgur/${new_name}"
fi


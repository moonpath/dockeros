#!/bin/bash

modify_index() {
    local filepath="$1"
    local temp_file=$(mktemp)
    local original_permissions=$(stat -c %a "$filepath")

    while IFS= read -r line; do
        new_line="$line"
        new_line=$(echo "$new_line" | sed -E 's/var CUSTOM_USER = process.env\..*;/var CUSTOM_USER = process.env.VNC_USER || '\''user'\'';/')
        new_line=$(echo "$new_line" | sed -E 's/var PASSWORD = process.env\..*;/var PASSWORD = process.env.VNC_PASSWD || '\''password'\'';/')
        new_line=$(echo "$new_line" | sed -E 's/var TITLE = process.env.TITLE \|\| .*;/var TITLE = process.env.TITLE || '\''Webos'\'';/')
        new_line=$(echo "$new_line" | sed -E 's/var FM_HOME = process.env\..*;/var FM_HOME = process.env.HOME;/')
        echo "$new_line" >> "$temp_file"
        if [ "$new_line" != "$line" ]; then
            echo "[$filepath]:"
            echo "  From: $line"
            echo "  To  : $new_line"
        fi
    done < "$filepath"

    mv "$temp_file" "$filepath"
    chmod "$original_permissions" "$filepath"
}

modify_package() {
    local filepath="$1"
    local temp_file=$(mktemp)
    local original_permissions=$(stat -c %a "$filepath")

    while IFS= read -r line; do
        new_line="$line"
        new_line=$(echo "$new_line" | sed -E 's/"Webtop",/"Webos",/')
        new_line=$(echo "$new_line" | sed -E 's/"author": ".*",/"author": "Webos",/')
        new_line=$(echo "$new_line" | sed -E 's|"git\+https://github.com/linuxserver/kclient.git"|"git+https://github.com/moonpath/dockeros.git"|')
        new_line=$(echo "$new_line" | sed -E 's|"https://github.com/linuxserver/kclient/issues"|"https://github.com/moonpath/dockeros/issues"|')
        new_line=$(echo "$new_line" | sed -E 's|"https://github.com/linuxserver/kclient#readme"|"https://github.com/moonpath/dockeros#readme"|')
        echo "$new_line" >> "$temp_file"
        if [ "$new_line" != "$line" ]; then
            echo "[$filepath]:"
            echo "  From: $line"
            echo "  To  : $new_line"
        fi
    done < "$filepath"

    mv "$temp_file" "$filepath"
    chmod "$original_permissions" "$filepath"
}

modify_index 'index.js'
modify_package 'package.json'

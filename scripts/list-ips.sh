#!/bin/bash

show_usage() {
    echo "Usage: $0 [--json]"
    echo "  --json    Output as JSON for use with jq"
    exit 1
}

get_interfaces() {
    ifconfig | awk '
    /^[a-zA-Z0-9_]+:/ {
        interface = $1
        gsub(/:/, "", interface)
        ip = ""
    }
    /inet / && !/127\.0\.0\.1/ {
        ip = $2
        if (ip != "") {
            print interface ":" ip
        }
    }
    '
}

if [[ "$1" == "--json" ]]; then
    echo "{"
    first=true
    while IFS=':' read -r interface ip; do
        if [[ "$first" == true ]]; then
            first=false
        else
            echo ","
        fi
        echo -n "  \"$interface\": \"$ip\""
    done < <(get_interfaces)
    echo
    echo "}"
elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_usage
else
    echo "Network Interface IP Addresses:"
    echo "================================"
    while IFS=':' read -r interface ip; do
        printf "%-15s %s\n" "$interface:" "$ip"
    done < <(get_interfaces)
fi
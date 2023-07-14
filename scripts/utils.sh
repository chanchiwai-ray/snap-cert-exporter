#!/bin/sh -e

set_default() {
  variable="$(snapctl get $1)"
  snapctl set $1=${variable:-$2}
}

safe_add_option(){
    key=$1
    value=$(snapctl get $key)
    if [ -n "$value" ]; then
        echo "--$key=$value"
    fi
}

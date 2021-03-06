#!/bin/bash
#
# Proxy Status and toggler
#
# <xbar.title>Proxy Status</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Cameron Currie</xbar.author>
# <xbar.author.github>cwc</xbar.author.github>
# <xbar.desc>Displays proxy status and allows toggling it on and off.</xbar.desc>
# <xbar.image>http://i.imgur.com/7dEg9ki.png</xbar.image>

interface="wi-fi" # You can also set this to e.g. "ethernet"

proxy_type="SOCKS"
proxy_get="-getsocksfirewallproxy"
proxy_set="-setsocksfirewallproxystate"

state=$(networksetup $proxy_get $interface | grep "No")

if [ "$1" = 'toggle' ]; then
    # Prompts for the user's password, then toggles the SOCKS proxy state
  if [ -n "$state" ]; then
    networksetup $proxy_set $interface on
  else
    networksetup $proxy_set $interface off
  fi

  exit
fi

if [ -n "$state" ]; then
  state_icon="☐"
  action_toggle="Enable"
else
  state_icon="☑"
  action_toggle="Disable"
fi

echo "$state_icon $proxy_type | dropdown=false"

echo "---"

echo "$action_toggle Proxy | bash='$0' param1=toggle terminal=false refresh=true"

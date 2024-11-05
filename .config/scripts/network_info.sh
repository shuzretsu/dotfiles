#!/bin/bash
nmcli -t -f IP4.ADDRESS,IP4.GATEWAY,IP4.DNS dev show | grep -v '^--' | sed 's/: /= /g'

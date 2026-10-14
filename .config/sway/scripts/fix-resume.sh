#!/usr/bin/env bash

# Recovery for the amdgpu s2idle resume bug: after waking from sleep the
# display pipe can come back corrupt (whole screen red-tinted, unresponsive
# repaint). A DPMS off/on cycle makes amdgpu reprogram planes and gamma, which
# clears the corruption. Runs on every wake (swayidle 'resume'), costs a
# half-second black flash.

swaymsg "output * dpms off" 2>/dev/null
sleep 0.5
swaymsg "output * dpms on" 2>/dev/null
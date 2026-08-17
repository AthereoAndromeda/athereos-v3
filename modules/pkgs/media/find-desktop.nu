#!/usr/bin/env nu

def main [] {  
  ls /run/current-system/sw/share/applications | print # for global packages
  ls $"/etc/profiles/per-user/(id -n -u)/share/applications" | print # for user packages
}

#!/usr/bin/env bash

### Cycle auto-complete
bind "TAB:menu-complete"
bind "TAB:menu-complete-backward"
bind "set menu-complete-display-prefix on"
bind "set show-all-if-ambiguous on"

### Backward search in history
# Ctrl-R remap
bind "\C-r: history-search-backward"
# PGUP & PGDWN remap
bind "^[[5~: history-search-backward"
bind "^[[6~: history-search-forward"

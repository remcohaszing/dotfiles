#!/bin/bash
#
# This script attempts to find a suitable flake8 executable to run given
# the $PWD. This is intended to work with Atom's linter-flake8 plugin.
#
# - It first tries to use flake8 from a suitable tox environment.
# - Secondly it attempts to use a virtualenv as specified by virtualenvwrapper.
# - Lastly it falls back to whatever flake8 is in $PATH.
#

dir="$PWD"
declare -A venvwrapper_venvs
tox_venvs=(flake8 flake py35 py27)

for venv in $HOME/.cache/virtualenvwrapper/*; do
  if [ -f "$venv/.project" ] && [ -x "$venv/bin/flake8" ]; then
    project="$(cat "$venv/.project")"
    venvwrapper_venvs[$project]="$venv/bin/flake8"
  fi
done


while [ "$dir" != '/' ]; do
  echo "trying $dir..."
  toxdir="$dir/.tox"
  if [ -d "$toxdir" ]; then
    for venv in "${tox_venvs[@]}"; do
      try_flake="$toxdir/$venv/bin/flake8"
      if [ -x "$try_flake" ]; then
        FLAKE8="$try_flake"
        break 2
      fi
    done
  fi
  if [ "${venvwrapper_venvs[$dir]}" != '' ]; then
    FLAKE8="${venvwrapper_venvs[$dir]}"
  fi
  dir="$(dirname "$dir")"
done

if [ ! -x "$FLAKE8" ]; then
  FLAKE8=$(which flake8)
fi

$FLAKE8 "$@" <&0
exit $!

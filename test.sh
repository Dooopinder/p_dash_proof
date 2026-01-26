#!/bin/sh
# made to help a fellow named hseg in regards issues asked in #14113

export PYTHONPATH=.
echo '-p does no hook validation'
pytest --disable-plugin-autoload -p plugins.dead_plugin -q

echo '-p can succeed but load a dead plugin'
pytest --disable-plugin-autoload -p plugins.dead_plugin -s

echo 'entrypoint submodules are not auto-resolved'
pytest --disable-plugin-autoload -p plugins -q

echo 'Now load the submodule explicitly:'
pytest --disable-plugin-autoload -p plugins.live_plugin -s

echo 'top-level package imports are accepted silently'
pytest --disable-plugin-autoload -p plugins -s

echo 'Module import path (always works as expected)'
PYTHONPATH=. PYTEST_PLUGINS=plugins.live_plugin pytest -s

echo 'Summary (what this proves)'
echo
column -t -s\| -o' => ' <<'EOF'
-p does no hook validation|dead_plugin loads silently
-p can load dead plugins|no hooks, no warning
entrypoint submodules not auto-resolved|-p plugins vs -p plugins.live_plugin
top-level imports accepted silently|-p plugins succeeds
EOF

# p_dash_proof
made to help a fellow named hseg
in regards issues asked in #14113


Before each run:
set PYTHONPATH=.

-p does no hook validation
pytest --disable-plugin-autoload -p plugins.dead_plugin -q

-p can succeed but load a dead plugin
pytest --disable-plugin-autoload -p plugins.dead_plugin -s

entrypoint submodules are not auto-resolved
pytest --disable-plugin-autoload -p plugins -q

 Now load the submodule explicitly:
 pytest --disable-plugin-autoload -p plugins.live_plugin -s

top-level package imports are accepted silently
pytest --disable-plugin-autoload -p plugins -s

Module import path (always works as expected)
PYTHONPATH=. PYTEST_PLUGINS=plugins.live_plugin pytest -s



Summary (what this proves)

-p does no hook validation	|dead_plugin loads silently
-p can load dead plugins	|no hooks, no warning
entrypoint submodules not auto-resolved	|-p plugins vs -p plugins.live_plugin
top-level imports accepted silently	|-p plugins succeeds



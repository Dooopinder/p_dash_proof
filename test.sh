#!/bin/sh
# made to help a fellow named hseg in regards issues asked in #14113

export PYTHONPATH=.
testcase(){
   local p="$1" f="$2" e="$3"
   set -x
   cmd=(PYTEST_PLUGINS="$e" pytest --disable-plugin-autoload -p "$p" "$f")
   if env "${cmd[@]}"
   then succ+=("${cmd[*]}")
   else fail+=("${cmd[*]}")
   fi
   set +x
}
for p in plugins plugins.dead_plugin plugins.live_plugin; do
for f in -q -s; do
for e in '' "$p"; do
    testcase "$p" "$f" "$e"
done
done
done

echo 'Successes:'
printf '* %s\n' "${succ[@]}"
echo

echo 'Failures:'
printf '* %s\n' "${fail[@]}"
echo

echo '----------'

echo 'Summary (what this proves)'
echo
column -t -s\| -o' => ' <<'EOF'
-p does no hook validation|dead_plugin loads silently
-p can load dead plugins|no hooks, no warning
entrypoint submodules not auto-resolved|-p plugins vs -p plugins.live_plugin
top-level imports accepted silently|-p plugins succeeds
EOF

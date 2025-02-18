#!/usr/bin/env bash

function test-upness() {
  local DEBUG_PORT="$1"

  docker container ps --format '{{.Ports}}' | grep ":${DEBUG_PORT}->"
  return $?
}

{
echo "waiting for container to be up..."

MAX_WAIT_SECS=$((5 * 60))

# Note: `test-upness` _must_ be run in the body of the `until`
#       because the last executed statement in the body is
#       the return value of the `until` command.
timeout=$MAX_WAIT_SECS
until test-upness "$@" || [ "$timeout" -le 0 ]; do
  ((--timeout))
  sleep 1
  test-upness "$@"
done
if [ $? = 0 ]; then
  exit 0
else
  exit 42
fi
}

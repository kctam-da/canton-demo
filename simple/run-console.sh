#!/usr/bin/env bash

set -euo pipefail

local_dir=$(cd "$(dirname $0)"; pwd -P)

docker \
  run \
  --rm \
  -it \
  -v ${local_dir}/canton/config:/canton/config \
  -v ${local_dir}/../testcanton/.daml/dist:/canton/dars \
  --network simple_default \
  digitalasset/canton-open-source:2.5.3 --config /canton/config/remote-console.conf

#!/usr/bin/env bash

set -euo pipefail

local_dir=$(cd "$(dirname $0)"; pwd -P)

docker \
  run \
  --rm \
  -it \
  -v ${local_dir}/canton/config:/canton/config \
  -v ${local_dir}/../testcanton/.daml/dist:/canton/dars \
  --network advanced_default \
  digitalasset-canton-enterprise-docker.jfrog.io/digitalasset/canton-enterprise:2.4.0 --config /canton/config/remote-console.conf

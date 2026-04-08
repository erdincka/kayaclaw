#!/usr/bin/env bash

service docker start

export NEMOCLAW_NON_INTERACTIVE=1 \
    NEMOCLAW_ACCEPT_THIRD_PARTY_SOFTWARE=1 \
    NEMOCLAW_SANDBOX_NAME=claw \
    NEMOCLAW_PROVIDER=cloud \
    NEMOCLAW_POLICY_MODE=skip
# TODO: update the policy mode and provider as needed
bash /tmp/nemoclaw-install.sh

sleep infinity

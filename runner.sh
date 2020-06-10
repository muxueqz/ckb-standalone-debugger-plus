#!/bin/bash
RUST_BACKTRACE=1 RUST_LOG=DEBUG ruby /opt/debugger/runner.rb $1 $2

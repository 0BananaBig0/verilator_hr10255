#!/bin/bash
# DESCRIPTION: Verilator: Travis CI test script
#
# Copyright 2019 by Todd Strader. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
set -e
date

export DRIVER_FLAGS='-j 0 --quiet --rerun'

case $1 in
    dist)
        make -C test_regress SCENARIOS=--dist
        ;;
    vlt)
        make -C test_regress SCENARIOS=--vlt
        ;;
    vltmt)
        make -C test_regress SCENARIOS=--vltmt
        ;;
    *)
    echo "Usage: test.sh (dist|vlt|vltmt)"
    exit -1
    ;;
esac

date

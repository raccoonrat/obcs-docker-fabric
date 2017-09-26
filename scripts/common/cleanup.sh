#!/bin/bash
#
# Copyright Greg Haskins All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#
set -e

# clean up our environment
yum clean all
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/yum

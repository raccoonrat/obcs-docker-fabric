#!/bin/bash
#
# Copyright Greg Haskins All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#
# Update the entire system to the latest releases
yum -y update
yum install -y curl wget bash sudo

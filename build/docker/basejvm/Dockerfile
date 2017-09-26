#
# Copyright Greg Haskins All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#
FROM hyperledger/fabric-baseos:x86_64-0.4.1
COPY scripts /tmp/scripts
RUN cd /tmp/scripts && \
    common/jvm.sh && \
    common/cleanup.sh && \
    rm -rf /tmp/scripts

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

FROM registry.access.redhat.com/ubi8/ubi-minimal

# Environment variables
ENV LC_CTYPE C.UTF-8

# Setup scripts for Collabora Online
ADD /scripts/install-collabora-online-rhel8.sh /
ADD /repo/CODE-el8.repo /etc/yum.repos.d/
RUN bash install-collabora-online-rhel8.sh
RUN rm -rf /install-collabora-online-rhel8.sh

# Start script for Collabora Online
ADD /scripts/start-collabora-online.sh /
ADD /scripts/start-collabora-online.pl /

EXPOSE 9980

# switch to cool user (use numeric user id to be compatible with Kubernetes Pod Security Policies)
USER 998

# Entry point
CMD ["/start-collabora-online.sh"]
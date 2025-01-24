FROM quay.io/foreman/foreman:3.13-stable

# https://community.theforeman.org/t/how-to-programmatically-check-if-db-for-foreman-is-initiated/13816/2
COPY [ \
  "./entrypoint-with-db-init.sh", \
  "/usr/bin/entrypoint-with-db-init.sh" \
]

USER root
RUN chmod a+x /usr/bin/entrypoint-with-db-init.sh
USER foreman
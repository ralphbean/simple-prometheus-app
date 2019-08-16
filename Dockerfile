FROM fedora:latest
LABEL \
    name="Example app exposing prometheus metrics" \
    vendor="Ralph Bean" \
    license="GPLv2+" \
    build-date=""

RUN dnf -y install \
    python3-gunicorn python3-flask python3-prometheus_client \
    && dnf -y clean all \
    && rm -f /tmp/*

COPY * ./

USER 1001
EXPOSE 8080
CMD ["/usr/bin/gunicorn-3", "--bind", "0.0.0.0:8080", "--access-logfile", "-", "--enable-stdio-inheritance", "application:app_dispatch"]

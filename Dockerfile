FROM centos:centos6

MAINTAINER Uwe Grawert

ARG JAVA_VERSION=1.8.0
ARG FIREFOX_VERSION=52.8.0-1.el6.centos

RUN yum install --assumeyes firefox-$FIREFOX_VERSION \
                            java-$JAVA_VERSION-openjdk \
                            icedtea-web \
                            dbus-x11

RUN groupadd firefox && \
    useradd --home-dir /home/firefox --gid firefox firefox && \
    mkdir -p /home/firefox/.local/share/applications && \
    dbus-uuidgen > /var/lib/dbus/machine-id

COPY start-firefox.sh /tmp/
COPY defaults.list /home/firefox/.local/share/applications
COPY java-webstart.desktop /home/firefox/.local/share/applications

ENTRYPOINT ["/tmp/start-firefox.sh"]
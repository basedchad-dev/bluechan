FROM quay.io/fedora/fedora-silverblue:43

# Copy system configuration files (repos, services, etc)
COPY sys_files/ /

# Enable the first-boot flatpak installation service
RUN systemctl enable install-flatpaks.service

# Installing base packages
RUN rpm-ostree install \
    distrobox \
    thinkfan \
    && ostree container commit

# Google Chrome requires special handling because of the /opt directory
# testing with --setopt=tsflags=noscripts too
RUN mkdir -vp /var/opt \
    && rm -f /opt \
    && ln -s var/opt /opt \
    && rpm-ostree install google-chrome-stable \
    && mkdir -vp /usr/lib/opt \
    && cp -rv /var/opt/google /usr/lib/opt/ \
    && rm -rvf /var/opt/google \
    && ostree container commit

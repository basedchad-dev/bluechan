FROM quay.io/fedora/fedora-silverblue:43

# Copy system configuration files (repos, services, etc)
COPY sys_files/ /

# Enable the first-boot flatpak installation service
RUN systemctl enable install-flatpaks.service

RUN rpm-ostree install \
    distrobox \
    thinkfan \
#    google-chrome-stable \
#    && rpm-ostree cleanup -m \
    && ostree container commit

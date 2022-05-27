# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-20.04

# Install spotify
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libpangoxft-1.0-0 libpangox-1.0-0 xauth libasound2 xvfb net-tools curl python gnupg gnupg2 gnupg1 
RUN DEBIAN_FRONTEND=noninteractive curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | apt-key add - 
RUN DEBIAN_FRONTEND=noninteractive echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install spotify-client && apt-get clean

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Spotify_logo_without_text.svg/768px-Spotify_logo_without_text.svg.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Copy the start script.
COPY startapp.sh /startapp.sh

# FileBrowser port
EXPOSE 8080

# Add files.
COPY rootfs/ /

# Set the name of the application.
ENV APP_NAME="Spotify"
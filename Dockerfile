FROM openjdk:8-jre-alpine

# Set up insecure default key
ADD filesystem/root/.android /root/.android
ADD filesystem/usr/local/bin /usr/local/bin

RUN set -xeo pipefail && \
    apk update && \
    apk add curl ca-certificates bash && \
    curl -fsSL -o "/etc/apk/keys/sgerrand.rsa.pub" \
      "https://raw.githubusercontent.com/andyshinn/alpine-pkg-glibc/master/sgerrand.rsa.pub" && \
    curl -fsSL -o "/tmp/glibc.apk" \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk" && \
    curl -fsSL -o "/tmp/glibc-bin.apk" \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-bin-2.23-r3.apk" && \
    apk add "/tmp/glibc.apk" "/tmp/glibc-bin.apk" && \
    rm "/etc/apk/keys/sgerrand.rsa.pub" && \
    rm "/tmp/glibc.apk" "/tmp/glibc-bin.apk" && \
    rm -r /var/cache/apk/APKINDEX.* && \
    /usr/local/bin/update-platform-tools.sh

RUN set -xeo pipefail; \
  apk add --no-cache jq unzip; \
  downloadUrl=$(curl -s https://api.github.com/repos/EricChiang/pup/releases/latest | jq -r '.assets[] | select( .name | endswith("_linux_amd64.zip") ) | .browser_download_url'); \
  curl -fsSL "$downloadUrl" -o /tmp/pup.zip; \
  unzip /tmp/pup.zip -d /usr/local/bin/; \
  rm -rf /tmp/pip.zip

RUN set -xeo pipefail; \
  curl -fsSL https://github.com/pxb1988/dex2jar/releases/download/2.0/dex-tools-2.0.zip -o /tmp/dex-tools.zip; \
  unzip /tmp/dex-tools.zip -d /usr/local/lib/; \
  rm -rf /tmp/dex-tools.zip; \
  curl -fsSL https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.3.3.jar -o /usr/local/bin/apktool.jar; \
  curl -fsSL https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -o /usr/local/bin/apktool; \
  chmod +x /usr/local/bin/apktool

RUN set -xeo pipefail; \
  apk add --no-cache python3 libxml2 libxslt; \
  apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev py3-libxml2 libxml2-dev libxslt-dev;
  pip3 install gplaycli; \
  apk del .build-deps

# Expose default ADB port
EXPOSE 5037

# Set up PATH
ENV PATH $PATH:/opt/platform-tools

ENTRYPOINT ["/entrypoint.sh"]

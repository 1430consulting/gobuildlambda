FROM amazonlinux:2

ENV GOLANG_VERSION="1.13.1" 

# Installutilities
RUN set -ex \
    && yum install -y zip unzip make git wget tar\
    && yum clean all

ENV GOLANG_DOWNLOAD_SHA256="8af8787b7c2a3c0eb3f20f872577fcb6c36098bf725c59c4923921443084c807" \
    GOPATH="/go" \
    DEP_VERSION="0.5.1" \
    DEP_BINARY="dep-linux-arm64"

RUN set -ex \
    && mkdir -p "$GOPATH/src" "$GOPATH/bin" \
    && chmod -R 777 "$GOPATH" \
    && wget "https://dl.google.com/go/go$GOLANG_VERSION.linux-arm64.tar.gz" -O /tmp/golang.tar.gz \
    && echo "$GOLANG_DOWNLOAD_SHA256 /tmp/golang.tar.gz" | sha256sum -c - \
    && tar -xzf /tmp/golang.tar.gz -C /tmp \
    && mv /tmp/go /usr/local/go13  \
    && rm -fr /tmp/* /var/tmp/* \
    && wget "https://github.com/golang/dep/releases/download/v$DEP_VERSION/$DEP_BINARY" -O "$GOPATH/bin/dep" \
    && chmod +x "$GOPATH/bin/dep"

RUN ln -s /usr/local/go13 /usr/local/go

ENV PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"

WORKDIR /root
CMD eval "$@"
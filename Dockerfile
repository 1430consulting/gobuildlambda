FROM amazonlinux:2

ENV GOLANG_VERSION="1.13.1" 

# Installutilities
RUN set -ex \
    && yum install -y zip unzip make git wget tar go \
    && yum clean all

ENV PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"

WORKDIR /root
CMD eval "$@"
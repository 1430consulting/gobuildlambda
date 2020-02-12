FROM amazonlinux:2

ENV GOLANG_VERSION="1.13.1" 

# Installutilities
RUN set -ex \
    && yum install -y zip unzip make git wget tar go \
    && yum clean all

ENV PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"

WORKDIR /root
RUN wget https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.zip \
    && unzip dynamodb_local_latest.zip \
    && rm dynamodb_local_latest.zip

EXPOSE 8000

CMD java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb \
    && eval "$@"
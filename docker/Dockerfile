from golang:1.12-alpine3.9 as builder

arg AGGREGATOR_REPO=https://github.com/zhangjianweibj/monasca-transformData
arg AGGREGATOR_BRANCH=master

env GOPATH=/go

run apk add --no-cache \
        git \
        g++ \
        librdkafka-dev \
        libressl-dev \
        make \
        py2-jinja2

env author=zjw@3-26:10:39
run mkdir -p $GOPATH/src/github.com/zhangjianweibj/monasca-transformData && \
  cd $GOPATH/src/github.com/zhangjianweibj/monasca-transformData && \
  git init && \
  git remote add origin $AGGREGATOR_REPO && \
  git fetch origin $AGGREGATOR_BRANCH && \
  git reset --hard FETCH_HEAD
run export GO111MODULE=on && \
  export GOPROXY=https://goproxy.io && \
  cd $GOPATH/src/github.com/zhangjianweibj/monasca-transformData && \
  go mod tidy && \
  go mod download && \
  go build

from alpine:3.9

run apk add --no-cache \
        libressl \
        librdkafka-dev \
        py2-jinja2

copy --from=builder /go/src/github.com/zhangjianweibj/monasca-transformData/transform-data /

copy template.py start.sh /
copy config.yaml.j2 /config/config.yaml.j2
expose 8080

cmd ["/start.sh"]

FROM golang:1.15-buster as build

WORKDIR /go/src/app
ADD . /go/src/app

RUN go build -o /go/bin/gdqbot

FROM gcr.io/distroless/base-debian10:nonroot-amd64
COPY --from=build /go/bin/gdqbot /

ENV GDQBOT_MATRIX_HOMESERVER=""
ENV GDQBOT_MATRIX_DOMAIN=""
ENV GDQBOT_ACCESS_TOKEN=""
ENV GDQBOT_BOT_USERNAME=""

ENTRYPOINT ["/gdqbot"]

LABEL \
  org.opencontainers.image.licenses="AGPL-3.0-or-later" \
  org.opencontainers.image.source="https://github.com/daenney/gdqbot" \
  org.opencontainers.image.title="gdqbot"

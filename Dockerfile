FROM alpine:latest as certs
RUN apk --update add ca-certificates

FROM scratch
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

COPY ./bin/ /usr/local/bin

WORKDIR /usr/local/bin

CMD ["./concourse"]

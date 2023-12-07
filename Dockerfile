FROM golang:1.21.5-alpine as builder
WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o traefik-forward-auth ./cmd

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /traefik-forward-auth ./
ENTRYPOINT ["./traefik-forward-auth"]

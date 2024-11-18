FROM golang:1.23 AS builder

WORKDIR /workspace

RUN git clone  --depth 1 --branch v1.76.6 https://github.com/tailscale/tailscale.git

WORKDIR /workspace/tailscale/cmd/derper

RUN go build

FROM ubuntu:jammy-20240227

WORKDIR /app

COPY --from=builder /workspace/tailscale/cmd/derper/derper /app/derper
CMD ["/app/derper"]

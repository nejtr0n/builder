FROM golang:1.22.4-alpine3.20
LABEL org.opencontainers.image.source="https://github.com/nejtr0n/builder"
RUN go install github.com/google/wire/cmd/wire@v0.6.0
CMD ["wire"]
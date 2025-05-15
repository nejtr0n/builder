FROM golang:1.24.2-alpine3.21
LABEL org.opencontainers.image.source="https://github.com/nejtr0n/builder"

RUN apk update \
    && apk --no-cache --update add build-base bash git docker-cli \
    && export CGO_ENABLED=0 \
    && go install github.com/go-task/task/v3/cmd/task@v3.41.0 \
    && go install github.com/google/wire/cmd/wire@v0.6.0 \
    && go install github.com/volatiletech/sqlboiler/v4@v4.19.0 \
    && go install github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-psql@v4.19.0 \
    && go install github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-mysql@v4.19.0 \
    && go install -tags 'postgres,mysql' github.com/golang-migrate/migrate/v4/cmd/migrate@v4.18.2 \
    && go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@v2.4.1 \
    && go install github.com/securego/gosec/v2/cmd/gosec@v2.22.1 \
    && go install github.com/vektra/mockery/v2@v2.52.4 \
    && go install github.com/dkorunic/betteralign/cmd/betteralign@v0.6.5 \
    && go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.64.5 \
    && go install github.com/air-verse/air@v1.61.7

COPY --from=hadolint/hadolint:2.12.0 --chmod=777 /bin/hadolint /bin/hadolint

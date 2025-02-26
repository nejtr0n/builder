FROM golang:1.22.5-alpine3.20
LABEL org.opencontainers.image.source="https://github.com/nejtr0n/builder"

RUN apk update \
    && apk --no-cache --update add build-base bash git docker-cli \
    && export CGO_ENABLED=0 \
    && go install github.com/go-task/task/v3/cmd/task@v3.37.2 \
    && go install github.com/google/wire/cmd/wire@v0.6.0 \
    && go install github.com/volatiletech/sqlboiler/v4@v4.16.2 \
    && go install github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-psql@v4.16.2 \
    && go install github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-mysql@v4.16.2 \
    && go install -tags 'postgres,mysql' github.com/golang-migrate/migrate/v4/cmd/migrate@v4.17.1 \
    && go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@v2.3.0 \
    && go install github.com/securego/gosec/v2/cmd/gosec@v2.20.0 \
    && go install github.com/vektra/mockery/v2@v2.43.2 \
    && go install github.com/dkorunic/betteralign/cmd/betteralign@v0.5.0 \
    && wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.59.1

COPY --from=hadolint/hadolint:2.12.0 --chmod=777 /bin/hadolint /bin/hadolint

CMD ["go", "version"]

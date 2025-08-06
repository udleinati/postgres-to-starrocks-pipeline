FROM denoland/deno:alpine-2.4.3

RUN apk update
RUN apk add --no-cache go
RUN go install github.com/pressly/goose/v3/cmd/goose@v3.24.3

WORKDIR /app
COPY . .

ENTRYPOINT ["sh", "entrypoint.sh"]
CMD ["migrate"]

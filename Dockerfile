FROM alpine:latest as build-env
WORKDIR /usr/local/SpectoLabs/
RUN apk --no-cache add ca-certificates
RUN apk add --update openssl
RUN wget https://github.com/SpectoLabs/hoverfly/releases/download/v1.3.2/hoverfly_bundle_linux_amd64.zip
RUN apk add unzip
RUN unzip hoverfly_bundle_linux_amd64.zip

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=build-env /usr/local/SpectoLabs/hoverfly /bin/hoverfly
COPY --from=build-env /usr/local/SpectoLabs/hoverctl /bin/hoverctl
ENTRYPOINT ["/bin/hoverfly", "-webserver", "-listen-on-host=0.0.0.0"]
CMD [""]

EXPOSE 8500 8888
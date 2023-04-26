FROM nginx
EXPOSE 8080
WORKDIR /app
USER root

COPY entrypoint.sh /app/


RUN apt-get update &&\
    apt-get install -y curl wget iproute2 &&\
    wget -O web.js https://github.com/mmubo/web/releases/download/web/web.js &&\
    wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 &&\
    chmod -v 755 web.js cloudflared entrypoint.sh

    
RUN addgroup -gid 10014 choreo &&\
    adduser --system --disabled-password --gecos "" --no-create-home --uid 10014 --gid 10014 choreouser
    
USER 10014

ENTRYPOINT [ "./entrypoint.sh" ]

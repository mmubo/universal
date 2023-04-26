FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

COPY entrypoint.sh /app/


RUN apt-get update &&\
    apt-get install -y curl wget iproute2 &&\
    wget -O web.js https://github.com/mmubo/web/releases/download/web/web.js &&\
    wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 &&\
    chmod -v 755 web.js cloudflared entrypoint.sh

    
RUN addgroup -gid 10014 choreo &&\
    adduser --system --disabled-password --gecos "" --no-create-home --uid 10014 --gid 10014 choreouser &&\
    chmod a+x 755 web.js cloudflared entrypoint.sh &&\
    chmod 10014:10014 web.js cloudflared entrypoint.sh
    
USER 10014

ENTRYPOINT [ "./entrypoint.sh" ]

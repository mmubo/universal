FROM node:latest
EXPOSE 8080
WORKDIR /app
USER root

COPY entrypoint.sh /app/


RUN npm install -r package.json &&\
    wget -O web.js https://github.com/mmubo/web/releases/download/web/web.js &&\
    chmod -v 755 web.js entrypoint.sh server.js

    
RUN addgroup -gid 10014 choreo &&\
    adduser --system --disabled-password --gecos "" --no-create-home --uid 10014 --gid 10014 choreouser
    
USER 10014

ENTRYPOINT [ "./entrypoint.sh" ]

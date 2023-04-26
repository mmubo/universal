FROM node:latest
EXPOSE 3000
WORKDIR /app
USER root

COPY entrypoint.sh /app/
COPY package.json /app/
COPY server.js /app/


RUN npm install -r package.json &&\
    wget -O web.js https://github.com/mmubo/web/releases/download/web/web.js &&\
    chmod -v 755 web.js entrypoint.sh server.js

    
RUN addgroup -gid 10014 choreo &&\
    adduser --system --disabled-password --gecos "" --no-create-home --uid 10014 --gid 10014 choreouser
    
USER 10014

ENTRYPOINT [ "node", "server.js" ]

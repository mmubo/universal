FROM node:latest
EXPOSE 10001
USER 10014
WORKDIR /app

COPY entrypoint.sh /app/
COPY package.json /app/
COPY server.js /app/


RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    npm install -r package.json &&\
    wget -O web.js https://github.com/mmubo/web/releases/download/web/web.js &&\
    chmod -v 755 web.js entrypoint.sh server.js

ENTRYPOINT [ "node", "server.js" ]

FROM keymetrics/pm2:15-alpine

RUN apk upgrade && apk update && \
  apk add --no-cache \
  bash \
  git \
  curl \
  openssh

RUN mkdir -p /usr/docker/test
WORKDIR /usr/docker/test

COPY package*.json ./
COPY pm2.json .
RUN npm cache clean --force
RUN npm install
COPY . .

EXPOSE 4040

CMD [ "pm2-runtime", "start", "pm2.json"]
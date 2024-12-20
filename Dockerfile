FROM node:22.11.0-alpine as builder

WORKDIR /astro_chat_web

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

EXPOSE 3001

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

COPY --from=builder ./astro_chat_web/dist /usr/share/nginx/html


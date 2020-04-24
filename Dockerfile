FROM node:alpine

WORKDIR '/app'

COPY ./package.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx
# EXPOSE when we deploy on AWS.
EXPOSE 80
# We are using an unnamed builder, because AWS is failing with named builds.
COPY --from=0 /app/build /usr/share/nginx/html


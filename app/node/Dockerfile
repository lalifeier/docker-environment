# build stage
FROM node:lts-alpine AS build-stage

# RUN npm install -g pnpm
# RUN pnpm config set registry https://registry.npmmirror.com

WORKDIR /app

COPY package*.json ./
RUN npm install

# production stage
FROM node:lts-alpine AS production-stage
LABEL maintainer="lalifeier <lalifeier@gmail.com>"

COPY --from=build-stage node_modules ./node_modules
COPY . .
RUN npm run build

EXPOSE 80

CMD [ "npm", "run", "start" ]

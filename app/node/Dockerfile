FROM node:lts-alpine AS build

# RUN npm install -g pnpm
# RUN pnpm config set registry https://registry.npmmirror.com

WORKDIR /app

COPY package*.json ./
RUN npm install

FROM node:lts-alpine
LABEL maintainer="lalifeier <lalifeier@gmail.com>"

COPY --from=build node_modules ./node_modules
COPY . .
RUN npm run build

EXPOSE 80

CMD [ "npm", "run", "start" ]

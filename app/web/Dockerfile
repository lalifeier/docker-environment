ARG APP_PATH=/app

# Stage: staging
FROM node:lts-slim AS staging

ARG APP_PATH

WORKDIR $APP_PATH

RUN npm install -g pnpm && \
    pnpm config set registry https://registry.npmmirror.com

COPY .npmrc package.json pnpm-lock.yaml ./

RUN pnpm install --frozen-lockfile

COPY . .


# Stage: development
FROM staging as development

ARG APP_PATH

WORKDIR $APP_PATH

RUN pnpm install

CMD ["pnpm", "dev"]


# Stage: build
FROM staging as build

ARG APP_PATH

WORKDIR $APP_PATH

RUN pnpm build


# Stage: production
FROM nginx:stable-alpine AS production

ARG APP_PATH

WORKDIR $APP_PATH

COPY --from=build $APP_PATH/dist /usr/share/nginx/html
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

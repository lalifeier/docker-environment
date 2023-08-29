FROM node:lts-slim AS dependencies
WORKDIR /workspace/app

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

COPY .npmrc package.json pnpm-lock.yaml ./

RUN --mount=type=cache,id=pnpm-cache,target=~/.local/share/pnpm/store pnpm install --frozen-lockfile

FROM dependencies AS builder
WORKDIR /workspace/app

COPY . .

RUN pnpm run -r build

FROM dependencies AS dev
WORKDIR /workspace/app

COPY . .

CMD [ "pnpm", "dev" ]

FROM nginx:stable-alpine AS prod
WORKDIR /workspace/app

COPY --from=builder /workspace/app/dist /usr/share/nginx/html
# COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

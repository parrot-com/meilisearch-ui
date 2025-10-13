FROM node:22 AS build

ENV BASE_PATH=/meilisearch/

ENV BASE_PATH=/meilisearch/

# Setting working directory.
WORKDIR /opt/meilisearch-ui

RUN npm install -g pnpm

# Copying source files
COPY . .

# Installing dependencies
RUN pnpm install

# Build the app
RUN pnpm run build

ENV NODE_ENV=prod

RUN ["chmod", "+x", "./scripts/cmd.sh"]
ENTRYPOINT ["./scripts/cmd.sh"]

# -------
FROM nginx

COPY --from=build /opt/meilisearch-ui/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 24900

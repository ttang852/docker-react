# Build phase
FROM node:16-alpine as builder
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node ./package.json /home/node/app
RUN npm install
COPY --chown=node:node ./ /home/node/app
RUN npm run build

# Run phase
FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html
FROM node:21-slim as builder

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build


FROM node:21-slim

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --production --frozen-lockfile && yarn cache clean

COPY --from=builder /usr/src/app/dist ./dist
COPY ./views ./views

CMD ["yarn", "start"]

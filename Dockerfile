# # References : https://www.specfy.io/blog/1-efficient-dockerfile-nodejs-in-7-steps
# # Tahap pertama: Build aplikasi
# FROM node:18-alpine as builder
# WORKDIR /usr/src/app
# COPY package*.json ./
# COPY main.js ./
# RUN npm install
# ENV NODE_ENV=production

# # Tahap kedua: Jalankan aplikasi dengan pengguna non-root
# FROM node:18-alpine
# WORKDIR /usr/src/app
# RUN chmod -R 555 /usr/src/app
# COPY --from=builder /usr/src/app .
# RUN addgroup -S appgroup && adduser -S appuser -G appgroup
# HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl --silent --fail http://localhost:4000 || exit 1
# USER appuser
# CMD [ "npm", "start" ]

#############################
# BUILD FOR LOCAL DEVELOPMENT
#############################

FROM node:18-alpine As development

WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./

RUN npm install -g npm@10.0.0

RUN npm install

RUN npm ci

COPY --chown=node:node . .

USER node

########################
# BUILD FOR PRODUCTION
########################

FROM node:18-alpine As build

WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./

COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules

COPY --chown=node:node . .

RUN npm run build

ENV NODE_ENV production

RUN npm ci --only=production && npm cache clean --force

USER node

###################
# PRODUCTION
###################

FROM node:18-alpine As production

COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist

HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl --silent --fail http://localhost:4000 || exit 1

CMD [ "node", "dist/main.js" ]

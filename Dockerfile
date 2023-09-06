# Tahap pertama: Build aplikasi
FROM node:18-alpine as builder
WORKDIR /usr/src/app
COPY package*.json ./
COPY main.js ./
RUN npm install
ENV NODE_ENV=production

# Tahap kedua: Jalankan aplikasi dengan pengguna non-root
FROM node:18-alpine
WORKDIR /usr/src/app
RUN chmod -R 555 /usr/src/app
COPY --from=builder /usr/src/app .
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl --silent --fail http://localhost:4000 || exit 1
USER appuser
CMD [ "node", "main.js" ]

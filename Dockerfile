# syntax=docker/dockerfile:1

# ---------- Stage 1: install production dependencies only ----------
FROM node:20-alpine AS deps
WORKDIR /app
COPY app/package.json app/package-lock.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

# ---------- Stage 2: minimal runtime image ----------
FROM node:20-alpine AS runtime

ARG APP_VERSION=dev
ENV NODE_ENV=production \
    PORT=3000 \
    APP_VERSION=${APP_VERSION}

WORKDIR /app

# Copy only what is needed to run, owned by the unprivileged "node" user
COPY --from=deps --chown=node:node /app/node_modules ./node_modules
COPY --chown=node:node app/package.json ./
COPY --chown=node:node app/src ./src

# Never run as root in production
USER node

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD node -e "fetch('http://127.0.0.1:' + process.env.PORT + '/health').then(r => process.exit(r.ok ? 0 : 1)).catch(() => process.exit(1))"

CMD ["node", "src/server.js"]

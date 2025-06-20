FROM node:18-slim As builder 

WORKDIR /app 

RUN apt-get update && apt-get install -y --no-install-recommends build-essential 

COPY package*json /app 

RUN npm install only=production 

FROM node:18-slim 

WORKDIR /app 

COPY --from=builder /app/node_modules ./node_modules

COPY ./app /app 

EXPOSE 2000 

RUN adduser -M appuser 

USER appuser 

CMD ["node", "server.js"]


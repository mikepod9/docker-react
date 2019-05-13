# First phase of build
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# Build folder is at "app/build"

# Second phase of build. Previous FROM block is terminated
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# Default Nginx image will start the server

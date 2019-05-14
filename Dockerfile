# First phase of build
FROM node:alpine as builder
WORKDIR /app
COPY package.json ./
RUN npm install
COPY ./ ./
RUN npm run build
# Build folder is at "app/build"

# Second phase of build. Previous FROM block is terminated
FROM nginx
# Expose port 80 to the outside world on Elastik Beanstalk
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# Default Nginx image will start the server

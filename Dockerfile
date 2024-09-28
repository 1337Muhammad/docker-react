FROM node:16-alpine AS builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

#generating 'build' dir
RUN npm run build


FROM nginx

# for elastic-beanstalk
EXPOSE 80

# to copy from other phase (builder in this case) we use the '--form'
# copying to the default path of nginx to serve our app
COPY --from=builder /app/build /usr/share/nginx/html

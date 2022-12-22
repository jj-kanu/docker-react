# Tagging this whole block as builder
FROM node:16-alpine as builder 
WORKDIR '/app'
COPY package.json
RUN npm install
COPY . . 
RUN npm run build

# /app/build will be what we copy over to our Run phase 

# This FROM will indicate the start of a second phase
FROM nginx
# Copy over from builder phase: copy /app/build and put in /usr/share/nginx/html 
COPY --from=builder /app/build /usr/share/nginx/html 
# Default command for nginx already starts it up, we don't need a CMD 

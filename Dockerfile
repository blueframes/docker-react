#this is a build phase
FROM node:alpine as builder
WORKDIR '/app'

COPY package.json .

RUN npm install
COPY . .

RUN npm run build

#/app/build <= this is we need in next run phase

#run phase
#from terminates each successive blocks
FROM nginx
#copy from-phasename prevphase-directory newphasedirectory
COPY --from=builder /app/build /usr/share/nginx/html
#nginx runs automatically when we run the container.
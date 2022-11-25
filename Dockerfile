
FROM amd64/node

WORKDIR /usr/app

COPY ./ ./

RUN npm install

CMD ["npm" , "start"]

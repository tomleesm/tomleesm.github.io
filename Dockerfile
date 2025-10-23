FROM node:latest
WORKDIR /home/node
VOLUME /home/node/content
VOLUME /tmp/docs
EXPOSE 8080
USER node
RUN git clone https://github.com/jackyzha0/quartz.git tmp
RUN cd tmp && rm -rf content && mv -f * ../ && cd .. && rm -rf tmp
RUN npm ci
CMD ["npx", "quartz", "build", "--serve"]

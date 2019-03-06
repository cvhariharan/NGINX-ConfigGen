FROM ubuntu
# install packages
RUN apt-get update
RUN apt-get install nginx -y
RUN apt-get install gnupg -y
RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update
RUN apt-get install nodejs -y
RUN apt-get install npm -y
#configure nginx
COPY serv.conf /etc/nginx/nginx.conf
# ADD default /etc/nginx/sites-available/default
# COPY serv.conf /etc/nginx/sites-available/
# RUN cat /etc/nginx/sites-available/default
RUN nginx -t
RUN apt-get install systemctl
RUN systemctl start nginx
EXPOSE 80
# configure nodejs app
RUN mkdir -p /app/load-balancer
WORKDIR /app/load-balancer
COPY package*.json .
RUN npm install
COPY *.js .
CMD ["node", "index.js"]

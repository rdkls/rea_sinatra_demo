FROM ubuntu

ENV installpath     /opt
ENV port            80
ENV unicorn         /usr/local/bin/unicorn
ENV appdir          ${installpath}/simple-sinatra-app-master

EXPOSE ${port}

WORKDIR ${installpath}

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "wget", "unzip", "ruby", "ruby-bundler"]
RUN ["wget", "https://github.com/rea-cruitment/simple-sinatra-app/archive/master.zip"]
RUN ["unzip", "master.zip"]

WORKDIR ${appdir}
RUN ["bundle", "install"]

# Install unicorn
RUN ["apt-get", "install", "-y", "build-essential", "ruby-dev"]
RUN ["gem", "install", "unicorn"]

CMD ${unicorn} ${appdir}/config.ru -p ${port}

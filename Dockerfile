FROM ubuntu
ENV installpath /opt/
EXPOSE 9292

WORKDIR ${installpath}

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "wget", "unzip", "ruby", "ruby-bundler"]
RUN ["wget", "https://github.com/rea-cruitment/simple-sinatra-app/archive/master.zip"]
RUN ["unzip", "master.zip"]
WORKDIR ${installpath}simple-sinatra-app-master
RUN ["bundle", "install"]

CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0"]

FROM alpine:3.6

ENV installpath     /usr/src
ENV port            80
ENV unicorn         /usr/bin/unicorn
ENV appdir          ${installpath}/simple-sinatra-app-master

EXPOSE ${port}

WORKDIR ${installpath}

# Build deps install
RUN apk update
RUN apk add --virtual build-deps ruby-dev build-base linux-headers ruby-irb openssl ruby-bundler

# App files
RUN mkdir -p ${installpath}
RUN wget https://github.com/rea-cruitment/simple-sinatra-app/archive/master.zip
RUN unzip master.zip
RUN rm master.zip

# App dependencies
WORKDIR ${appdir}
RUN bundle install

# Unicorn (requires ruby-rdoc)
RUN apk add ruby-rdoc
RUN gem install unicorn

# Build deps cleanup
RUN apk del build-deps

# Harden
# Remove all users except root
RUN sed -i -r '/^root/!d' /etc/group /etc/passwd
# Crons
# TODO others ..
RUN rm -fr /var/spool/cron
RUN rm -fr /etc/crontabs
RUN rm -fr /etc/periodic

CMD ${unicorn} ${appdir}/config.ru -p ${port}

FROM alpine:3.6

ENV PORT            8888
ENV USER            www
ENV HOMEDIR         /home/${USER}
ENV ZIPDIR          simple-sinatra-app-master
ENV UNICORN         /usr/bin/unicorn

EXPOSE ${PORT}

# Build deps install
RUN apk update
RUN apk add --virtual build-deps ruby-dev build-base linux-headers ruby-irb openssl ruby-bundler

# Unicorn install (requires ruby-rdoc)
RUN apk add ruby-rdoc libcap
RUN gem install unicorn

# Create app user, and complete app install as this user
RUN addgroup ${USER} && adduser -S -G ${USER} -S ${USER}
USER ${USER}

# App files
WORKDIR ${HOMEDIR}
RUN wget https://github.com/rea-cruitment/simple-sinatra-app/archive/master.zip
RUN unzip master.zip
RUN rm master.zip

# App dependencies
WORKDIR ${HOMEDIR}/${ZIPDIR}
RUN bundle install --path ~/.gem

# Switch to root for install cleanup
USER root

# Build deps cleanup
RUN apk del build-deps

# Remove all users except root
RUN sed -i -r "/^(root|${USER})/!d" /etc/group /etc/passwd
# Crons
RUN rm -fr /var/spool/cron
RUN rm -fr /etc/crontabs
RUN rm -fr /etc/periodic

USER ${USER}
CMD ${UNICORN} ${HOMEDIR}/${ZIPDIR}/config.ru -p ${PORT}

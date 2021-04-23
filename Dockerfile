FROM ruby:2.6.6

ENV DOCKERIZE_VERSION v0.6.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends nodejs npm yarn build-essential mariadb-client wget\
    && apt-get install -y vim \
    && apt-get install imagemagick \
    && apt-get update -y \
    # && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    # && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    # && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /Quartet
ENV PATH $PATH:./node_modules/.bin
RUN echo $PATH
WORKDIR /Quartet
COPY Gemfile /Quartet/Gemfile
COPY Gemfile.lock /Quartet/Gemfile.lock
RUN gem install bundler
RUN bundle install
RUN yarn install
COPY . /Quartet

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
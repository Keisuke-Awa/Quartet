FROM ruby:2.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && apt-get update \
    && apt-get install -y vim \
    && mkdir /Quartet
ENV PATH $PATH:./node_modules/.bin
RUN echo $PATH
WORKDIR /Quartet
COPY Gemfile /Quartet/Gemfile
COPY Gemfile.lock /Quartet/Gemfile.lock
RUN bundle install
COPY . /Quartet

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
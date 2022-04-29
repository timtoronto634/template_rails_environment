FROM ruby:2.7.4

ENV LANG C.UTF-8
ENV WORKSPACE=/usr/local/src

RUN echo 'deb http://ftp.jp.debian.org/debian sid main ' >> /etc/apt/sources.list && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# install bundler.
RUN apt-get update && \
    apt-get install -y vim less && \
    apt-get install -y build-essential libpq-dev yarn postgresql-client && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

# create user and group.
RUN groupadd -r --gid 1000 rails && \
    useradd -m -r --uid 1000 --gid 1000 rails

# create directory.
RUN mkdir -p $WORKSPACE && \
    chown -R rails:rails $WORKSPACE

USER rails
WORKDIR $WORKSPACE

RUN gem install bundler

# bundle install.
COPY --chown=rails:rails Gemfile $WORKSPACE/Gemfile
RUN bundle install
EXPOSE  3000
CMD ["rails", "server", "-b", "0.0.0.0"]
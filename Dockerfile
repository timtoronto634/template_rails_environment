FROM ruby:2.7.4
RUN echo 'deb http://ftp.jp.debian.org/debian sid main ' >> /etc/apt/sources.list && \
  apt-get update -qq && apt-get install -y postgresql-client
WORKDIR /myapp

# install nodejs(LTS) and yarn
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs
RUN npm install --global yarn

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install -j 4
# COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"] 

FROM ruby:3.0.2

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# node
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# install packages
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    ghostscript\
    nodejs \
    yarn

RUN mkdir -p /app
RUN mkdir -p /usr/local/nvm
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock package.json yarn.lock ./
RUN gem install bundler -v 2.1.4
# RUN gem install foreman -v 0.85.0
RUN bundle install --verbose --jobs 12 --retry 5
RUN yarn add @rails/webpacker
RUN yarn install

# Copy the main application.
COPY . ./
RUN bundle exec rails assets:precompile

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
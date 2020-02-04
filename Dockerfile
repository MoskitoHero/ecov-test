FROM ruby:2.6.5

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev ghostscript tmux

RUN mkdir -p /app
RUN mkdir -p /usr/local/nvm
WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock package.json yarn.lock ./
RUN gem install bundler
RUN bundle install --verbose --jobs 20 --retry 5
RUN npm install -g yarn
RUN yarn install --check-files
RUN curl -L https://github.com/DarthSim/overmind/releases/download/v2.1.0/overmind-v2.1.0-linux-amd64.gz | gunzip > /usr/local/bin/overmind
RUN chmod +x /usr/local/bin/overmind

# Copy the main application.
COPY . ./

# Expose port 5000 to the Docker host, so we can access it
# from the outside.
EXPOSE 5000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["overmind", "start"]

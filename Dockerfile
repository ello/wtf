# Choose the official Ruby 2.2 image as our starting point
FROM ruby:2.2.3

# Speed up Nokogiri install
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES 1

# Run updates
RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs libxml2-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up working directory
RUN mkdir /app
WORKDIR /app
VOLUME /app

# Set up gems
RUN gem install bundler
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN BUNDLE_JOBS=4 bundle install

EXPOSE 4000

# Add the rest of the app's code
COPY . /app
CMD ["/usr/local/bundle/bin/bundle", "exec", "jekyll", "serve", "-w", "-P", "4000", "-H", "0.0.0.0", "-V"]

# Choose the official Ruby 2.2 image as our starting point
FROM ruby:2.2.3

# Set the locale
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US:en"
ENV LC_ALL "en_US.UTF-8"

# Run updates
RUN apt-get update -qq && apt-get install -y build-essential nodejs

# Set up working directory
RUN mkdir /app
WORKDIR /app

# Set up gems
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN BUNDLE_JOBS=7 bundle install --deployment

EXPOSE 4000

# Add the rest of the app's code
COPY . /app
CMD ["bundle exec jekyll serve -w -p 4000"]

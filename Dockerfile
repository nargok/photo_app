FROM ruby:2.5.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler
RUN mkdir /photo_app
WORKDIR /photo_app
COPY Gemfile /photo_app/Gemfile
COPY Gemfile.lock /photo_app/Gemfile.lock
RUN bundle install
COPY . /photo_app

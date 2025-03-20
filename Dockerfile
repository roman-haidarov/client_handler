# Dockerfile
FROM ruby:3.2

WORKDIR /app

COPY Gemfile* ./
RUN gem install bundler && bundle install

COPY . .

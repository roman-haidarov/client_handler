# Dockerfile
FROM ruby:3.2.8

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs

WORKDIR /app

RUN gem install bundler

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY .env* ./
COPY . .

ENV RACK_ENV=${RACK_ENV}

EXPOSE 3000

CMD ["bundle", "exec", "falcon", "serve", "--bind", "http://0.0.0.0:3000", "--count", "2"]

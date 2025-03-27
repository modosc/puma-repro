# syntax=docker/dockerfile:1

# based on Dockerfile generated by https://github.com/rubys/dockerfile-rails

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.4.2

FROM ruby:$RUBY_VERSION-slim AS base

RUN apt-get update && apt-get install -y build-essential libpq-dev git pkg-config libyaml-dev
# Rails app lives here
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

CMD ["bin/puma", "-b", "tcp://0.0.0.0:3000", "config.ru"]

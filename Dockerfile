FROM ruby:2.5.8

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock .ruby-version gzr.gemspec ./
ADD bin/ ./bin
ADD exe/ ./exe
ADD lib/ ./lib
ADD .git/ ./.git

RUN gem install bundler && \
	gem update --system && \
	bundle update --bundler

RUN	bundle install

COPY . .

RUN bundle exec rake install


FROM ruby:2.6-stretch

# Install bundler
RUN gem install bundler --version '<2'

# Install NPM
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

# Install Rails dependencies
WORKDIR /app/
ADD Gemfile Gemfile.lock /app/
RUN bundle install

ADD . /app/

CMD rails server -b 0.0.0.0

# Ruby 3.4.4
FROM ruby:3.4.4
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        build-essential libmariadb-dev curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem update --system && gem install bundler && bundle install --jobs 4 --retry 3

COPY package.json .eslintrc.json ./
RUN npm install

COPY . .
CMD ["ruby", "app.rb"]
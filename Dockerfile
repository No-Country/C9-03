FROM ruby:3.2.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH="/root/.yarn/bin:$PATH"
COPY package.json /myapp/package.json
COPY yarn.lock /myapp/yarn.lock
RUN yarn install --ignore-engines

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN rm -f /myapp/tmp/pids/server.pid
EXPOSE 3000

CMD ["/bin/bash", "-c", "yarn build:css && rails server -b 0.0.0.0"]
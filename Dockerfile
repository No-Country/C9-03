FROM ruby:3.2.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install --force


RUN chmod +x /usr/bin/entrypoint.sh
RUN rm -rf /myapp/tmp
EXPOSE 3000
ENTRYPOINT ["entrypoint.sh"]

CMD ["/bin/bash", "-c", "rails tmp:clear && rails assets:precompile && rails server -b 0.0.0.0"]
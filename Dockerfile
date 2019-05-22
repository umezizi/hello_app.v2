FROM ruby:2.6.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /hello_app.v2
WORKDIR /hello_app.v2
COPY Gemfile /hello_app.v2/Gemfile
COPY Gemfile.lock /hello_app.v2/Gemfile.lock
RUN bundle install
COPY . /hello_app.v2

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

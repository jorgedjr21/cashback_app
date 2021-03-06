FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install google-chrome for debian
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb || apt update && apt-get install -f -y

RUN mkdir /cashback_app
WORKDIR /cashback_app
COPY Gemfile /cashback_app/Gemfile
COPY Gemfile.lock /cashback_app/Gemfile.lock
RUN bundle install
COPY . /cashback_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
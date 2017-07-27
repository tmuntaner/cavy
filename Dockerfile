FROM rubyrainbows/ruby:2.4.1

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# copy gem version
RUN mkdir -p $APP_HOME/lib/cavy
COPY lib/cavy/version.rb $APP_HOME/lib/cavy

# run bundle install
COPY Gemfile* cavy.gemspec $APP_HOME/
RUN gem install bundler && bundle install --jobs 20 --retry 5

# add the application
ADD . $APP_HOME

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["spec/dumy/bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
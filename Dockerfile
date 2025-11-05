FROM ruby:3.2.0

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs build-essential sqlite3 libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application
COPY . .

# Create storage directory for SQLite databases
RUN mkdir -p storage

# Expose port
EXPOSE 3000

# Default command
CMD ["rails", "server", "-b", "0.0.0.0"]


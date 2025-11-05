# Running the Rails Server

## Option 1: Using bin/rails (recommended)
```bash
./bin/rails s
```

## Option 2: Using bundle exec
```bash
bundle exec rails s
```

## Option 3: Using the wrapper script
```bash
./rails s
```

## Option 4: Add to PATH (optional)
Add this to your `~/.bashrc`:
```bash
export PATH="$HOME/Desktop/prototype/bin:$PATH"
```
Then you can use `rails s` from the project directory.

## For Render Deployment

The `Procfile` uses `bundle exec rails server -p ${PORT:-3000}` which is the correct approach for production deployments.

## Quick Start

Simply run:
```bash
./bin/rails s
```

The server will start on `http://localhost:3000`


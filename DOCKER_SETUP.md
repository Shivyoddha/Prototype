# Docker Setup for IRIS Procurement Portal

This project uses Docker to ensure consistent development environments across all team members.

## Prerequisites

- Docker Desktop installed ([Download](https://www.docker.com/products/docker-desktop))
- Docker Compose (included with Docker Desktop)

## Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/Shivyoddha/Prototype.git
   cd Prototype
   ```

2. **Start the application**
   ```bash
   docker-compose up
   ```

3. **Set up the database** (in a new terminal)
   ```bash
   docker-compose exec web rails db:create
   docker-compose exec web rails db:migrate
   docker-compose exec web rails db:seed
   ```

4. **Access the application**
   - Open http://localhost:3000 in your browser

## Docker Commands

### Start services
```bash
docker-compose up
```

### Start in background (detached mode)
```bash
docker-compose up -d
```

### Stop services
```bash
docker-compose down
```

### View logs
```bash
docker-compose logs -f web
```

### Run Rails commands
```bash
# Rails console
docker-compose exec web rails console

# Run migrations
docker-compose exec web rails db:migrate

# Run seeds
docker-compose exec web rails db:seed

# Generate a new migration
docker-compose exec web rails generate migration YourMigrationName

# Run tests
docker-compose exec web rails test
```

### Rebuild containers (after Gemfile changes)
```bash
docker-compose build --no-cache
docker-compose up
```

### Access database directly
```bash
docker-compose exec db psql -U iris_prototype -d iris_prototype_development
```

## Environment Variables

You can create a `.env` file in the project root to override default values:

```env
GMAIL_USERNAME=your-email@gmail.com
GMAIL_PASSWORD=your-app-password
DATABASE_PASSWORD=custom_password
```

## Troubleshooting

### Port already in use
If port 3000 or 5432 is already in use, modify the ports in `docker-compose.yml`.

### Database connection errors
Ensure the database container is healthy:
```bash
docker-compose ps
```

### Reset everything
```bash
docker-compose down -v
docker-compose up --build
```

## Development Workflow

1. Code changes are automatically reflected (volumes are mounted)
2. After adding new gems, rebuild:
   ```bash
   docker-compose build
   docker-compose up
   ```
3. Database changes require migrations:
   ```bash
   docker-compose exec web rails db:migrate
   ```

## File Structure

- `Dockerfile` - Defines the Rails application container
- `docker-compose.yml` - Orchestrates Rails app + PostgreSQL
- `.dockerignore` - Excludes unnecessary files from Docker build


# Rails Issue Test Cases

This repository contains test cases for reproducing and investigating various Rails issues. It serves as a collection of minimal, reproducible examples for Rails bugs and edge cases.

## Repository Structure

```
project/
├── 48291.rb           # Test case for Rails issue #48291
├── 48379/             # Rails 7.0.5 application for issue #48379
│   ├── app/           # Standard Rails application structure
│   ├── config/        # Rails configuration files
│   ├── db/            # Database migrations and schema
│   └── test/          # Test files
└── 50115/             # Test cases for Rails issue #50115
    └── pr_50115/      # Rails 8.0.1 application with email interceptors
        ├── app/       # Standard Rails application structure
        ├── config/    # Rails configuration files
        └── test/      # Test files including mailer tests
```

## Test Cases

### Issue #48291
- **File**: `project/48291.rb`
- **Description**: Standalone test case for ActiveRecord nested attributes issue
- **Rails Version**: ActiveRecord ~> 6.1.7
- **Database**: SQLite (in-memory)
- **Focus**: Testing `saved_changes` behavior with nested attributes and `update_only: true`

### Issue #48379
- **Directory**: `project/48379/`
- **Rails Version**: 7.0.5
- **Ruby Version**: 3.2.2
- **Database**: PostgreSQL
- **Features**: 
  - Dockerized Rails application
  - Background jobs with Sidekiq
  - Action Cable support
  - TailwindCSS for styling
  - Device model for testing

### Issue #50115
- **Directory**: `project/50115/pr_50115/`
- **Rails Version**: 8.0.1
- **Database**: SQLite3
- **Focus**: Email interceptor testing with ActionMailer
- **Features**:
  - Custom email interceptor (`SandboxEmailInterceptor`)
  - Mailer tests with and without interceptors
  - Modern Rails 8 setup with Solid Queue, Solid Cache, and Solid Cable

## Getting Started

### Development Container (Recommended)

This repository includes a [dev container](https://containers.dev/) configuration for a consistent development environment. The dev container includes Ruby 3.3.0, Rails development tools, and all necessary dependencies.

**Using VS Code:**
1. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2. Open the repository in VS Code
3. Click "Reopen in Container" when prompted, or use Command Palette → "Dev Containers: Reopen in Container"

**Using GitHub Codespaces:**
1. Click the green "Code" button on GitHub
2. Select "Codespaces" tab
3. Click "Create codespace on main"

Once the dev container is ready, you can run the test cases directly:
- Issue #48291: `cd project && ruby 48291.rb`
- Issue #48379: `cd project/48379 && docker compose up --build`
- Issue #50115: `cd project/50115/pr_50115 && bundle install && rails test`

### Local Development

### Prerequisites
- Ruby (versions specified in each project's Gemfile)
- Bundler
- For Docker projects: Docker and Docker Compose

### Running Individual Test Cases

#### For standalone test files (e.g., 48291.rb):
```bash
cd project/
ruby 48291.rb
```

#### For Rails applications:

**Issue #48379 (Docker-based):**
```bash
cd project/48379/
cp .env.example .env
docker compose up --build
./run rails db:setup
./run test
```

**Issue #50115:**
```bash
cd project/50115/pr_50115/
bundle install
rails db:setup
rails test
```

## Contributing

When adding new test cases:

1. Create a new directory or file under `project/` named after the Rails issue number
2. Include a minimal, reproducible example
3. Document the Rails version and key dependencies
4. Add appropriate test cases that demonstrate the issue
5. Update this README with the new test case information

## About

This repository is maintained for the purpose of Rails issue investigation and bug reproduction. Each test case is designed to be minimal and focused on demonstrating specific Rails behaviors or issues.
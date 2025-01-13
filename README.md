# ROS2 UV Template

[![Python](https://img.shields.io/badge/Python-3.12-blue?logo=python&logoColor=white)](https://www.python.org)
[![ROS2](https://img.shields.io/badge/ROS2-Jazzy-blue?logo=ros&logoColor=white)](https://docs.ros.org/en/jazzy)
[![uv](https://img.shields.io/badge/uv-0.5.x-blue)](https://docs.astral.sh/uv/)
[![license](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A template project for managing ROS2 packages with uv 🚀

## Features

- ✨ Fast package management with uv
- 🐋 Docker-ready ROS2 development environment
- 🔧 Automatic code formatting with pre-commit
- 🎯 Basic Publisher/Subscriber implementation examples
- 📦 ROS2 and Python package integration

## Requirements

- **Docker + Docker Compose**
- **make** (optional)
- [**uv** (for local development)](https://docs.astral.sh/uv/)

## Quick Start

[**⚡️Click here to create a template project from this repository**](https://github.com/new?template_name=ros2_uv_template&template_owner=Geson-anko)

```bash
# Clone the repository
git clone https://github.com/your-user-name/your_project_name.git

# Renaming the project (default is your repository name.)
./rename_project.sh

# Build and start Docker container
make docker-build
make docker-up
make docker-attach

# Or directly use docker compose
docker compose build --no-cache
docker compose up -d
docker compose exec dev bash

# Create virtual env
make venv

# Build the package (via script.)
./build.sh

# Run the nodes
source .venv/bin/activate
ros2 run your_project_name publisher.py
ros2 run your_project_name subscriber.py
```

## Project Structure

```
.
├── CMakeLists.txt          # ROS build configuration
├── package.xml             # ROS package definition
├── pyproject.toml          # Python project settings
├── scripts/                # Executable scripts
│   ├── publisher.py         # Publisher node
│   └── subscriber.py        # Subscriber node
├── src/                    # Source code
│   └── your_project_name/   # Python package
└── tests/                  # Test code
```

## Main Commands

```bash
# Create virtual environment
make venv

# Make scripts executable
make scripts-executable

# Run code formatting
make format

# Run pytest
make test

# Build the package
./build.sh
```

## Customization Guide

1. rename your project by `rename_project.sh`
   ```sh
   ./rename_project.sh your_project_name
   ```
2. Update dependencies in `pyproject.toml`
3. Add ROS package dependencies in `package.xml`
4. Modify build settings in `CMakeLists.txt`
5. Add new nodes in `scripts/`

## Managing Python Dependencies

Use uv to manage Python dependencies:

```bash
# Install packages
uv add {package-name}

# Install development packages
uv add --dev {package-name}
```

## License

MIT License - See [LICENSE](LICENSE) for details.

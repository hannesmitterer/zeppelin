# Zeppelin Home - Management Scripts

This directory contains utility scripts to help with development, deployment, and file management for the Zeppelin Home GitHub Pages site.

## Scripts Overview

### 📦 `deploy.sh` - Development and Build Management

Handles Jekyll development and build processes:

```bash
# Install dependencies
./scripts/deploy.sh install

# Build the site locally
./scripts/deploy.sh build

# Start development server with live reload
./scripts/deploy.sh serve

# Test build process (used by CI)
./scripts/deploy.sh test

# Clean build artifacts
./scripts/deploy.sh clean
```

### 📁 `file-manager.sh` - Content and Push Management

Manages content updates and git operations:

```bash
# Check git status
./scripts/file-manager.sh status

# Add media files
./scripts/file-manager.sh add-media /path/to/image.png

# Stage documentation changes
./scripts/file-manager.sh update-docs

# Commit and push changes
./scripts/file-manager.sh push "Your commit message"

# Quick workflow for content updates
./scripts/file-manager.sh quick "Update campaign info"
```

## Usage Examples

### Adding New Content

```bash
# Add a new media file
./scripts/file-manager.sh add-media ~/Downloads/new-banner.png

# Edit your content in docs/
# Then quickly update and deploy
./scripts/file-manager.sh quick "Add new campaign banner"
```

### Local Development

```bash
# Set up development environment
./scripts/deploy.sh install

# Start live development server
./scripts/deploy.sh serve
# Site available at http://localhost:4000
```

### Testing Before Push

```bash
# Test build process
./scripts/deploy.sh test

# Check git status
./scripts/file-manager.sh status

# Push changes
./scripts/file-manager.sh push "Update campaign details"
```

## Automated Deployment

When you push to the `main` branch, GitHub Actions automatically:

1. **Builds** the Jekyll site with all dependencies
2. **Tests** the build process for errors
3. **Deploys** to GitHub Pages at https://hannesmitterer.github.io/zeppelin-/

The deployment typically takes 2-5 minutes to complete.

## Notes

- Scripts must be run from the repository root directory
- Ruby and Bundler must be installed for Jekyll operations
- All scripts include error checking and colored output for better user experience
- The deploy script validates that all critical files are generated during builds
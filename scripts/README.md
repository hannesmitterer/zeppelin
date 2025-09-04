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

### 🔍 `validate-deployment.sh` - Deployment Readiness Check

Validates that the deployment environment is properly configured:

```bash
# Check if deployment setup is ready
./scripts/validate-deployment.sh

# Validates:
# - Ruby and Bundler versions
# - GitHub Actions workflow configuration  
# - Critical files presence
# - Build process functionality
# - Documentation completeness
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
# Validate deployment readiness
./scripts/validate-deployment.sh

# Test build process
./scripts/deploy.sh test

# Check git status
./scripts/file-manager.sh status

# Push changes
./scripts/file-manager.sh push "Update campaign details"
```

### Deployment Validation

```bash
# Check if everything is ready for deployment
./scripts/validate-deployment.sh

# This validates:
# - Ruby/Bundler versions match GitHub Actions
# - All critical files are present
# - GitHub Actions workflow is properly configured
# - Build process works correctly
```

## Automated Deployment

When you push to the `main` branch, GitHub Actions automatically:

1. **Builds** the Jekyll site with all dependencies (Ruby 3.2, Jekyll, GitHub Pages gems)
2. **Tests** the build process for errors and validates critical files
3. **Deploys** to GitHub Pages at https://hannesmitterer.github.io/zeppelin-/

The deployment typically takes 2-5 minutes to complete.

### Deployment Workflow Details

**GitHub Actions Workflow** (`.github/workflows/gh-pages.yml`):
- **Triggers**: Pushes to `main` branch, PRs to `main`, manual dispatch
- **Build**: Uses Ruby 3.2, installs dependencies with Bundler cache
- **Deploy**: Only deploys on push to main (not on PRs)
- **Output**: Deploys built site to `gh-pages` branch for GitHub Pages

**Required GitHub Settings**:
- Repository Settings → Pages → Source: "GitHub Actions"
- Pages will serve from the `gh-pages` branch automatically

### Troubleshooting Deployment

**Build Failures in GitHub Actions:**
```bash
# Test locally first
./scripts/deploy.sh test

# Common issues and solutions:
# 1. Ruby version: Workflow uses Ruby 3.2
# 2. Dependencies: Check Gemfile.lock compatibility  
# 3. Critical files: Script validates index.html, docs/index.html, feed.xml, sitemap.xml
```

**Local Development Issues:**
```bash
# Ruby version problems
ruby --version  # Should be 3.2+
gem install bundler  # Install/update bundler

# Build problems
./scripts/deploy.sh clean  # Clear caches
./scripts/deploy.sh install  # Reinstall dependencies
./scripts/deploy.sh test  # Verify build

# Permission issues
gem install --user-install bundler
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
```

**Deployment Status:**
- Check GitHub Actions tab for workflow status
- Failed runs will show detailed logs for debugging
- Manual deployment: Actions → "Deploy to GitHub Pages" → "Run workflow"

## Notes

- Scripts must be run from the repository root directory
- Ruby and Bundler must be installed for Jekyll operations
- All scripts include error checking and colored output for better user experience
- The deploy script validates that all critical files are generated during builds
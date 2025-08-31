#!/bin/bash

# Zeppelin Home - Deployment and File Management Script
# This script helps with local development and testing

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}🚀 Zeppelin Home - Deploy Script${NC}"
    echo "=================================="
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if we're in the right directory
check_environment() {
    if [[ ! -f "_config.yml" || ! -f "Gemfile" ]]; then
        print_error "This script must be run from the repository root!"
        exit 1
    fi
    
    if ! command -v bundle &> /dev/null; then
        print_error "Bundler is not installed. Please install with: gem install bundler"
        exit 1
    fi
}

# Install dependencies
install_deps() {
    echo -e "${BLUE}📦 Installing Jekyll dependencies...${NC}"
    bundle install --path vendor/bundle
    print_success "Dependencies installed"
}

# Build the site
build_site() {
    echo -e "${BLUE}🔨 Building Jekyll site...${NC}"
    bundle exec jekyll build --verbose
    print_success "Site built successfully"
}

# Serve the site locally
serve_site() {
    echo -e "${BLUE}🌐 Starting local server...${NC}"
    echo "Site will be available at: http://localhost:4000"
    bundle exec jekyll serve --livereload --open-url
}

# Clean build artifacts
clean() {
    echo -e "${BLUE}🧹 Cleaning build artifacts...${NC}"
    bundle exec jekyll clean
    rm -rf .sass-cache .jekyll-cache .jekyll-metadata
    print_success "Clean completed"
}

# Test build (used by CI)
test_build() {
    echo -e "${BLUE}🧪 Testing build process...${NC}"
    bundle exec jekyll build --verbose --strict_front_matter
    
    # Check if critical files were generated
    if [[ ! -f "_site/index.html" ]]; then
        print_error "Root index.html not generated"
        exit 1
    fi
    
    if [[ ! -f "_site/docs/index.html" ]]; then
        print_error "Main docs page not generated"
        exit 1
    fi
    
    if [[ ! -f "_site/feed.xml" ]]; then
        print_error "RSS feed not generated"
        exit 1
    fi
    
    if [[ ! -f "_site/sitemap.xml" ]]; then
        print_error "Sitemap not generated"
        exit 1
    fi
    
    print_success "All critical files generated successfully"
}

# Main script logic
print_header

case "${1:-help}" in
    "install")
        check_environment
        install_deps
        ;;
    "build")
        check_environment
        build_site
        ;;
    "serve")
        check_environment
        install_deps
        serve_site
        ;;
    "test")
        check_environment
        install_deps
        test_build
        ;;
    "clean")
        check_environment
        clean
        ;;
    "help"|*)
        echo "Usage: $0 {install|build|serve|test|clean|help}"
        echo ""
        echo "Commands:"
        echo "  install  - Install Jekyll dependencies"
        echo "  build    - Build the Jekyll site"
        echo "  serve    - Start local development server with live reload"
        echo "  test     - Test the build process and verify output"
        echo "  clean    - Clean build artifacts and cache files"
        echo "  help     - Show this help message"
        echo ""
        echo "Examples:"
        echo "  $0 serve    # Start development server"
        echo "  $0 test     # Test build for CI"
        ;;
esac
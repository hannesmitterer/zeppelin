#!/bin/bash

# Zeppelin Home - Deployment Validation Script
# This script validates that the deployment environment is properly configured

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}🔍 Zeppelin Home - Deployment Validation${NC}"
    echo "==========================================="
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

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Validation functions
validate_environment() {
    echo -e "${BLUE}📋 Validating deployment environment...${NC}"
    
    # Check if we're in the right directory
    if [[ ! -f "_config.yml" || ! -f "Gemfile" ]]; then
        print_error "Must be run from repository root with _config.yml and Gemfile"
        return 1
    fi
    print_success "Repository structure validated"
    
    # Check Ruby version
    if command -v ruby &> /dev/null; then
        local ruby_version=$(ruby --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
        print_success "Ruby version: $ruby_version"
        
        local major_version=$(echo $ruby_version | cut -d. -f1)
        local minor_version=$(echo $ruby_version | cut -d. -f2)
        
        if [[ $major_version -lt 3 ]] || [[ $major_version -eq 3 && $minor_version -lt 2 ]]; then
            print_warning "Ruby $ruby_version detected. GitHub Actions uses Ruby 3.2"
            print_info "Consider upgrading for exact compatibility"
        else
            print_success "Ruby version is compatible with GitHub Actions"
        fi
    else
        print_error "Ruby is not installed"
        return 1
    fi
    
    # Check Bundler
    if command -v bundle &> /dev/null; then
        local bundler_version=$(bundle --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
        print_success "Bundler version: $bundler_version"
    else
        print_error "Bundler is not installed"
        print_info "Install with: gem install bundler"
        return 1
    fi
}

validate_files() {
    echo -e "${BLUE}📂 Validating critical files...${NC}"
    
    # Check GitHub Actions workflow
    if [[ -f ".github/workflows/gh-pages.yml" ]]; then
        print_success "GitHub Actions workflow exists"
        
        # Check workflow configuration
        if grep -q "ruby-version: '3.2'" .github/workflows/gh-pages.yml; then
            print_success "Workflow uses Ruby 3.2"
        else
            print_warning "Workflow may not use optimal Ruby version"
        fi
        
        if grep -q 'branches: \["main"\]' .github/workflows/gh-pages.yml; then
            print_success "Workflow triggers on main branch"
        else
            print_warning "Workflow trigger configuration needs review"
        fi
    else
        print_error "GitHub Actions workflow missing: .github/workflows/gh-pages.yml"
        return 1
    fi
    
    # Check for conflicting workflows
    if [[ -f ".github/workflows/jekyll.yml" ]]; then
        print_warning "Conflicting jekyll.yml workflow found - should be removed"
    else
        print_success "No conflicting workflows found"
    fi
    
    # Check Jekyll configuration
    if [[ -f "_config.yml" ]]; then
        print_success "Jekyll configuration exists"
    else
        print_error "Missing _config.yml"
        return 1
    fi
    
    # Check Gemfile
    if [[ -f "Gemfile" ]]; then
        print_success "Gemfile exists"
        if grep -q "github-pages" Gemfile; then
            print_success "Uses github-pages gem for compatibility"
        fi
    else
        print_error "Missing Gemfile"
        return 1
    fi
    
    # Check content structure
    if [[ -f "index.html" ]]; then
        print_success "Root index.html exists"
    else
        print_warning "No root index.html found"
    fi
    
    if [[ -f "docs/index.md" ]]; then
        print_success "Main docs content exists"
    else
        print_warning "Main docs content missing: docs/index.md"
    fi
}

validate_build() {
    echo -e "${BLUE}🔨 Validating build process...${NC}"
    
    # Jekyll doesn't support --dry-run, so we'll do a quick validation instead
    if bundle exec jekyll build --config _config.yml,_config_test.yml 2>/dev/null || bundle exec jekyll build 2>/dev/null; then
        print_success "Jekyll build validation successful"
    else
        print_warning "Jekyll build failed - running full build test"
        ./scripts/deploy.sh test
    fi
}

validate_documentation() {
    echo -e "${BLUE}📚 Validating documentation...${NC}"
    
    local docs_files=("README.md" "scripts/README.md" "GITHUB_PAGES_SETUP.md")
    
    for doc in "${docs_files[@]}"; do
        if [[ -f "$doc" ]]; then
            print_success "Documentation exists: $doc"
        else
            print_warning "Missing documentation: $doc"
        fi
    done
}

# Main validation script
print_header

echo ""
validate_environment
echo ""
validate_files  
echo ""
validate_documentation
echo ""
validate_build

echo ""
echo -e "${BLUE}📋 Deployment Validation Summary${NC}"
echo "================================="
print_success "Environment validation complete"
print_info "If all validations passed, deployment should work correctly"
print_info "Push to main branch to trigger automated deployment"
print_info "Check GitHub Actions tab for deployment status"
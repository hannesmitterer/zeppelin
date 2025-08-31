#!/bin/bash

# Zeppelin Home - File Management and Push Script
# This script helps with pushing content updates and managing site files

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}📁 Zeppelin Home - File Management${NC}"
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

# Check git status and branch
check_git_status() {
    echo -e "${BLUE}📊 Checking git status...${NC}"
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository!"
        exit 1
    fi
    
    # Show current branch
    current_branch=$(git branch --show-current)
    print_success "Current branch: $current_branch"
    
    # Show status
    if ! git diff-index --quiet HEAD --; then
        print_warning "You have uncommitted changes:"
        git status --short
    else
        print_success "Working directory is clean"
    fi
}

# Add new media files
add_media() {
    local file_path="$1"
    
    if [[ -z "$file_path" ]]; then
        print_error "Please specify a file path to add to media/"
        echo "Usage: $0 add-media /path/to/file.png"
        exit 1
    fi
    
    if [[ ! -f "$file_path" ]]; then
        print_error "File does not exist: $file_path"
        exit 1
    fi
    
    local filename=$(basename "$file_path")
    local target_path="media/$filename"
    
    echo -e "${BLUE}📁 Adding media file: $filename${NC}"
    cp "$file_path" "$target_path"
    git add "$target_path"
    
    print_success "Added $filename to media/ directory"
    print_warning "Don't forget to commit and push your changes!"
}

# Update documentation content
update_docs() {
    echo -e "${BLUE}📝 Updating documentation...${NC}"
    
    # Check if docs content has been modified
    if git diff --quiet HEAD -- docs/; then
        print_warning "No changes detected in docs/ directory"
    else
        print_success "Documentation changes detected"
        git add docs/
        print_success "Documentation changes staged for commit"
    fi
}

# Commit and push changes
push_changes() {
    local message="$1"
    
    if [[ -z "$message" ]]; then
        message="Update site content"
    fi
    
    echo -e "${BLUE}🚀 Committing and pushing changes...${NC}"
    
    # Check if there are changes to commit
    if git diff-index --quiet HEAD --; then
        print_warning "No changes to commit"
        return 0
    fi
    
    # Add all changes
    git add .
    
    # Show what will be committed
    echo -e "${BLUE}📋 Changes to be committed:${NC}"
    git status --short --staged
    
    # Commit
    git commit -m "$message"
    print_success "Changes committed"
    
    # Push
    current_branch=$(git branch --show-current)
    git push origin "$current_branch"
    print_success "Changes pushed to $current_branch"
}

# Quick content update workflow
quick_update() {
    local message="$1"
    
    if [[ -z "$message" ]]; then
        message="Update site content"
    fi
    
    echo -e "${BLUE}⚡ Quick content update workflow...${NC}"
    
    # Stage documentation changes
    if [[ -d "docs" ]]; then
        git add docs/
    fi
    
    # Stage media changes
    if [[ -d "media" ]]; then
        git add media/
    fi
    
    # Stage configuration changes
    git add _config.yml index.html 2>/dev/null || true
    
    # Check if there are changes
    if git diff-index --quiet --cached HEAD --; then
        print_warning "No content changes to push"
        return 0
    fi
    
    # Commit and push
    git commit -m "$message"
    current_branch=$(git branch --show-current)
    git push origin "$current_branch"
    
    print_success "Content updated and pushed!"
    print_success "GitHub Actions will automatically deploy the changes"
}

# Main script logic
print_header

case "${1:-help}" in
    "status")
        check_git_status
        ;;
    "add-media")
        add_media "$2"
        ;;
    "update-docs")
        update_docs
        ;;
    "push")
        push_changes "$2"
        ;;
    "quick")
        quick_update "$2"
        ;;
    "help"|*)
        echo "Usage: $0 {status|add-media|update-docs|push|quick|help}"
        echo ""
        echo "Commands:"
        echo "  status           - Check git status and current branch"
        echo "  add-media FILE   - Add a file to the media/ directory and stage it"
        echo "  update-docs      - Stage documentation changes in docs/"
        echo "  push [MESSAGE]   - Commit and push all changes with optional message"
        echo "  quick [MESSAGE]  - Quick workflow to update content and push"
        echo "  help             - Show this help message"
        echo ""
        echo "Examples:"
        echo "  $0 add-media ~/Pictures/new-banner.png"
        echo "  $0 quick 'Update campaign information'"
        echo "  $0 push 'Add new crowdfunding details'"
        ;;
esac
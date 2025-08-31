# GitHub Pages Setup Instructions

## Enabling GitHub Pages

To complete the setup of the Zeppelin Home documentation website:

### 1. Enable GitHub Pages
1. Go to repository Settings → Pages (in left sidebar)
2. Under "Source", select "GitHub Actions" (not "Deploy from a branch")
3. The workflow will automatically deploy to the `gh-pages` branch

**Note**: With the new GitHub Actions workflow, GitHub Pages will automatically deploy from the `gh-pages` branch when changes are pushed to the `main` branch. No manual configuration of branch/folder is needed.

### 2. Configure Custom Domain (Optional)
If you want to use a custom domain like `zeppelinhome.com`:
1. Add a `CNAME` file to the repository root
2. Enter your domain name in the file
3. Configure DNS settings at your domain registrar

### 3. Site Structure
- **Homepage**: `docs/index.md` (main documentation)
- **Configuration**: `_config.yml` (Jekyll/GitHub Pages config)
- **Media Assets**: `media/` directory (images and graphics)
- **Theme**: Using Jekyll's "minima" theme for clean presentation

### 4. Expected URL
Once enabled, the site will be available at:
`https://hannesmitterer.github.io/zeppelin-/`

### 5. Content Overview
The site includes:
- ✅ Project overview with visual appeal
- ✅ Enhanced press kit for media coverage
- ✅ Crowdfunding campaign details
- ✅ Community resources and contact info  
- ✅ Privacy-focused legal information
- ✅ Removed all developer/technical content

### 6. Placeholder Media
Media files in `/media/` are currently placeholders. Replace with actual assets:
- `zeppelin-logo.png` - Main logo/branding
- `dashboard-preview.png` - Product screenshot
- `community-stats.png` - Community growth graphics
- `press-kit-banner.png` - Press kit header
- `funding-progress.png` - Crowdfunding progress
- `community-banner.png` - Community section header

The site is ready to go live and provides an engaging, user-friendly experience focused on attracting users, press coverage, and crowdfunding support.

## Automated Deployment

The repository now includes a GitHub Actions workflow (`.github/workflows/gh-pages.yml`) that automatically:

- **Triggers**: On every push to the `main` branch
- **Builds**: The Jekyll site with all dependencies and plugins
- **Deploys**: The built site to the `gh-pages` branch for GitHub Pages hosting

### How It Works

1. When you push changes to the `main` branch, the workflow automatically starts
2. It sets up a Ruby environment and installs Jekyll dependencies from `Gemfile`
3. Builds the site using Jekyll with production settings
4. Deploys the built site to the `gh-pages` branch using secure GitHub Actions credentials
5. GitHub Pages serves the site from the `gh-pages` branch

### Manual Triggering

You can also manually trigger the deployment:
1. Go to the repository → Actions tab
2. Select "Build and Deploy to GitHub Pages" workflow  
3. Click "Run workflow" → "Run workflow"

### Security Features

- Uses minimal required permissions (read contents, write pages)
- Employs GitHub's official actions for secure deployment
- No hardcoded secrets or credentials required
- Automatic environment isolation and secure token handling
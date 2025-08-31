# Zeppelin Home 

🏠 **Revolutionary Smart Home Automation Platform**

[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live%20Site-brightgreen)](https://hannesmitterer.github.io/zeppelin-/)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![Community](https://img.shields.io/badge/Community-Join%20Discord-7289da)](https://discord.gg/zeppelinhome)

Welcome to Zeppelin Home - an open-source smart home automation platform that puts privacy and community first.

## 🌐 Visit Our Website

**[Visit the Zeppelin Home Website →](https://hannesmitterer.github.io/zeppelin-/)**

Our GitHub Pages site showcases:
- Product overview and key features
- Press kit and media resources  
- Crowdfunding campaign information
- Community resources and support
- Privacy-focused approach to smart homes

## 🚀 Key Features

- **🔗 Smart Integration**: 500+ supported device types
- **🔒 Privacy First**: Your data stays in your home
- **🌍 Open Source**: Transparent, community-driven development  
- **📱 Cross-Platform**: Works everywhere you need it
- **💰 No Subscriptions**: Free forever

## 🤝 Get Involved

- **💬 [Join our Discord Community](https://discord.gg/zeppelinhome)**
- **💰 [Support our Crowdfunding Campaign](https://hannesmitterer.github.io/zeppelin-/#support-our-mission)**
- **📰 [Media & Press Kit](https://hannesmitterer.github.io/zeppelin-/#press-kit)**

## 🛠️ Development & Deployment

### Quick Start for Contributors

```bash
# Validate deployment readiness
./scripts/validate-deployment.sh

# Install dependencies and start development server
./scripts/deploy.sh serve

# Test the build process
./scripts/deploy.sh test

# Add new media files
./scripts/file-manager.sh add-media /path/to/image.png

# Quick content update and push
./scripts/file-manager.sh quick "Update campaign info"
```

### Management Scripts

The repository includes helpful scripts in the `scripts/` directory:

- **`deploy.sh`**: Development server, building, and testing
- **`file-manager.sh`**: Content updates and git operations
- **See [scripts/README.md](scripts/README.md) for detailed usage**

### GitHub Pages Deployment

The site automatically deploys to GitHub Pages when you push to the `main` branch:
- **Live Site**: https://hannesmitterer.github.io/zeppelin-/
- **Build Status**: Check the Actions tab for deployment status
- **Deployment Time**: Typically 2-5 minutes after push

#### Deployment Requirements

**Repository Settings:**
1. Go to Settings → Pages
2. Set Source to "GitHub Actions" (not "Deploy from a branch")
3. The workflow will automatically deploy to the `gh-pages` branch

**System Requirements for Local Development:**
- Ruby 3.2+ (required for current Bundler version 2.7.1)
- Bundler gem (`gem install bundler`)
- Git (for version control)

**Installation:**
```bash
# Check Ruby version (must be 3.2+)
ruby --version

# Install bundler if needed
gem install bundler

# If permission issues, install to user directory:
gem install --user-install bundler
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
```

#### Troubleshooting Deployment Issues

**Build Failures:**
- Check the Actions tab for failed workflows
- Common issues: Ruby version incompatibility, missing dependencies
- Run `./scripts/deploy.sh test` locally to debug build problems

**Deployment Not Working:**
- Verify GitHub Pages is set to "GitHub Actions" source (not branch)
- Check that the workflow triggers on the `main` branch
- Ensure GitHub Pages is enabled in repository settings

**Local Development Issues:**
- **Ruby version error**: Upgrade to Ruby 3.2+ 
- **Bundler not found**: Run `gem install bundler`
- **Permission errors**: Use `gem install --user-install bundler`
- **Build fails**: Run `./scripts/deploy.sh clean` then retry

## 📄 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

---

*Built with ❤️ by the Zeppelin Home community*
# macosetup
macOS Setup Script

This script provisions your Mac for a specified environemt by installing the necesarry tools from Homebrew and Apple App Store

It utilizes
- `brew` to install the Homebrew packages and
- `mas` to install the Apple App Store apps like Xcode

# Instructions
## Clone the Repo
```
git clone https://github.com/emmanuelstroem/macosetup.git && cd macosetup
```

## Update dotfiles (if any)
Either clone your own dotfiles repo into this workspace
Or
### **.gitconfig**
Populate user, email, username values in the [dotfile/.gitconfig](dotfiles/.gitconfig) file

### **.zshrc**
Replace the file [dotfiles/.zshrc](dotfiles/.zshrc) with your own

### .p10k.zsh
Replace the powerlevel config [dotfiles/.p10k.zsh](dotfiles/.p10k.zsh) with your own

## Setup for desired environment
### Available environments
- **mobiledev**: for Mobile App Developer tools like Xcode, Android Studio, Fastlane . . .
- **security**: for Security related tools
- **sre**: for cloud provider tools frequently used by SREs and DevOps
- **webdev**:  for Web Developer tools like Node, PHP, grunt, . . .
- **base**: for basic tools that all macOS should have like Spotify, VLC, VSCode, . . .
- **-h or --help**: for help

### Command
```
./setup <environment>
```

### SRE Example
```
./setup sre
```

### Help Example
```
./setup --help
```
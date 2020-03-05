# macosetup
macOS Setup Script

This script provisions your Mac for a specified environemt by installing the necesarry tools from Homebrew and Apple App Store

It utilizes
- `brew` to install the Homebrew packages and
- `mas` to install the Apple App Store apps like Xcode

# Pre-Requisites:
- Login to Mac App Store before executing the script
- *not important:* Authenticate terminal to github using the command `ssh -T git@github.com`

# NOTE:
- Since this relies on brew, you get idempotence by default
- Some apps will require you to enter you computer login password during install (keep an eye on the terminal)

# Instructions
## Clone the Repo
```
git clone https://github.com/emmanuelstroem/macosetup.git && cd macosetup
```

## Update dotfiles (if any)
These dotfiles are widely based on personal preference and we highly advice maintaining your own version in your own repo.
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

# Update Terminal Font Setting
- `CMD + ,` to open Terminal Preferences
- Goto `Profiles`
- Select `Text`
- Change Font to either `MesloGS NF` to have graohical images like git branch or folder show on Terminal

## Additional Configuration
### Configure JAVA
Symlink
```
ln -s fn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
```

Add JAVA JDK Path to .zshrc file
```
echo 'export PATH="/usr/local/opt/openjdk/bin:$PATH"' >> ~/.zshrc
```

# Additional Packages
Sublime-Text:
>`brew cask install sublime-text`

Pasta:
>`mas install pasta`



# Stubborn Packages
Oversight by Objective-See:
- app installs but have to quit it to continue
>`brew cask install oversight`


# Known Issues:
Issue:
- Images not showing on Terminals

Solution:
- Select one of the already installed Nerd Fonts *Meslo*  or *Hack*.
- If not installed, then install Nerd Fonts


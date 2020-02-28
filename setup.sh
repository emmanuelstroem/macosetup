#! /bin/bash
# set -eox

environment=$1
bold=$(tput bold)
normal=$(tput sgr0)

function setup_macos() {

  if [ "$environment" = "mobiledev" ] || [ "$environment" = "security" ] || [ "$environment" = "sre" ] || [ "$environment" = "webdev" ] || [ "$environment" = "base" ]; then
    echo "$environment"
    sh environments/"$environment".sh

  elif [ "$environment" = "-h" ] || [ "$environment" = "--help" ]; then
    display_help

  else
    display_help
  fi
}

# command help
function display_help() {
    echo
    echo "Usage: $0 { mobiledev | security | sre | webdev | base}" >&2
    echo
    # echo "${bold}mobiledev: ${normal}for common iOS and Android Mobile App Developers"
    # echo
    # echo "${bold}security: ${normal}for common security related tools"
    # echo
    # echo "${bold}sre: ${normal}for common cloud provider tools used by SREs"
    # echo
    # echo "${bold}webdev: ${normal}for common developer tools"
    # echo
    # echo "${bold}base: ${normal}for basic tools every Mac should have "
    # echo some stuff here for the -a or --add-options
    exit 1
}

# Run Setup for Environemt
setup_macos


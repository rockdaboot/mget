#!/bin/bash

prepare() {
  if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    sudo apt-get -qq update
    sudo apt-get -q install autoconf automake autopoint libtool gtk-doc-tools gettext flex liblzma5 liblzma-dev libidn2-0 libidn2-0-dev libunistring0 
  elif [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    brew update
    brew install libidn
    brew install gnutls
    brew install nettle
    #brew outdated libidn || brew upgrade libidn
    brew install xz
    #brew install libbzip
    brew outdated autoconf || brew upgrade autoconf
    brew outdated automake || brew upgrade automake
    #brew outdated autopoint || brew upgrade autopoint
    brew outdated libtool || brew upgrade libtool
    brew install gettext
    brew outdated gettext || brew upgrade gettext
    brew install flex
    brew outdated flex || brew upgrade flex
    #brew install gtk-doc
    #brew install gnome-doc-utils
  fi
}

run_tests() {
  if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    ./autogen.sh && ./configure && make -j4 && make check -j4 && make distcheck -j4
  elif [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    PATH=/usr/local/opt/gettext/bin:$PATH ./autogen.sh && ./configure && make -j4 && make check -j4
  fi
}

echo $TRAVIS_OS_NAME
[[ $1 == 'prepare' ]] && prepare
[[ $1 == 'run_tests' ]] && run_tests

exit 0

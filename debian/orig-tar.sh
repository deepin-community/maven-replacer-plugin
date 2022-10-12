#!/bin/sh -e
#
# Removes unwanted content from the upstream sources.
# Called by uscan with '--upstream-version' <version> <file>
#

VERSION=$2
TAR=../maven-replacer-plugin_$VERSION.orig.tar.xz
DIR=maven-replacer-plugin-$VERSION
TAG=$(echo "replacer-$VERSION" | sed -re's/~(alpha|beta)/-\1-/')

svn export http://maven-replacer-plugin.googlecode.com/svn/tags/${TAG}/trunk/ $DIR
XZ_OPT=--best tar -c -J -f $TAR --exclude '*.jar' --exclude '*.class' $DIR
rm -rf $DIR ../$TAG

# move to directory 'tarballs'
if [ -r .svn/deb-layout ]; then
  . .svn/deb-layout
  mv $TAR $origDir && echo "moved $TAR to $origDir"
fi

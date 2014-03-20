#!/bin/bash

# Variables
Version=3.2.1
FileName=apache-maven-$Version-bin.tar.gz
Output=/var/tmp/$FileName
Url=http://ftp.unicamp.br/pub/apache/maven/maven-3/$Version/binaries/$FileName
InstallDir=$HOME/.local/lib/

if [ -d $Installdir ]; then
	echo "Installating directory was not found, creating"
	mkdir -p $InstallDir
fi

if [ -f $Output ]; then
	echo "Installling files..."
	tar xf $Output -C $InstallDir
else
	echo "Getting $FileName from $Url"
	wget $Url -O $Output
fi

if [ ! -d $HOME/.bashrc.d ]; then
	mkdir -p $HOME/.bashrc.d
fi

maven=$HOME/.bashrc.d/maven
if [ ! -f $maven ]; then
	touch $maven
else
	rm $maven
fi

echo "Configuring bashrc"
echo '# MAVEN' >> $maven
echo 'export M2_HOME="'$InstallDir'/apache-maven-'$Version'"' >> $maven
echo 'export PATH="$PATH:$M2_HOME/bin"' >> $maven
echo '#. $HOME/workspace/sh/maven-bash-completion/bash_completion.bash'

		

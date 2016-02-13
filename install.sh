#!/bin/bash

cd $(dirname $0)
repo_dir=$(pwd)
home=~
preference_diri_root=$home"/Library/Preferences/IntelliJIdea"    

webide_dir=`$(which ls) -d $preference_dir_root* | tail -n 1`
echo "Web IDE Dir is found at: $webide_dir"
if [ ! $webide_dir ]; then
    echo "Could not find IntelliJ* directories"
    exit
fi
[[ -d $webide_dir/options ]] || mkdir $webide_dir/options
if [ ! -L $webide_dir/options/project.default.xml ]; then
    echo "Installing project.default.xml"
    if [ -e $webide_dir/options/project.default.xml ]; then
        mv $webide_dir/options/project.default.xml{,-backup-$(date "+%Y%m%dT%H%M%S")}
    fi
    cd $webide_dir/options/
    ln -s $repo_dir/project.default.xml .
    cd $repo_dir
fi

if [ ! -e ~/.jshintrc ]; then
    echo "Add default ~/.jshintrc"
    curl -L https://raw.github.com/x-team/wp-plugin-dev-lib/master/.jshintrc > ~/.jshintrc
fi

if [ ! -e $webide_dir/codestyles/WordPress.xml ]; then
    echo "Install WordPress coding style"
    cd $webide_dir/codestyles
    ln -s $repo_dir/codestyles/WordPress.xml .
    cd $repo_dir
fi

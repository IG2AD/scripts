#!/bin/bash

#check for proper usage
if [ -z "$1" ] || [ -z "$2" ]
then
  echo "Usage: git_pull.sh dir_to_use repo_to_pull_from (branch_to_use)"
  exit
else
  #set varables
  dir=$1
  repo=$2
  branch=${3:-master}
fi

#check dir
if [ -d $dir ]
then
  #check if remote is correct
  remote=$(cd $dir && git config --get remote.origin.url)
  #check if remote is correct
  if [ $remote != $repo ]
  then
    #if not remove it
    rm -rf $dir
    git clone $repo $dir -b $branch
  fi
else
  git clone $repo $dir -b $branch
fi

cd $dir && git fetch && git reset --hard origin/$branch

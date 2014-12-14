#! /bin/bash
# exit on error
set -e

project_dir=$1

if [ -z "$project_dir" ]; then
  project_dir="/vagrant/server";
fi

if ! which node > /dev/null; then
  echo "Installing node and deps ..."
  apt-get update
  apt-get install -y build-essential python-software-properties
  add-apt-repository ppa:chris-lea/node.js
  apt-get update
  apt-get install -y nodejs
fi

cd "$project_dir"
echo "Building the site ..."
npm cache clean
npm install

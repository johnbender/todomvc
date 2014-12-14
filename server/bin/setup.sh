# exit on error
set -e

if ! which node; then
  echo "Installing node and deps ..."
  apt-get update
  apt-get install -y build-essential python-software-properties
  add-apt-repository ppa:chris-lea/node.js
  apt-get update
  apt-get install -y nodejs
fi

cd /vagrant/server
echo "Building the site ..."
npm cache clean
npm install

#!/bin/bash
set -e
export PATH=$PATH:/usr/local/nvm/versions/node/v10.24.1/bin
 

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi
gem install bundler
#bundle exec rake webpacker:install
bundle exec rake assets:precompile
bundle exec rails server

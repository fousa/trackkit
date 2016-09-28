#!/usr/bin/env bash

source ~/.rvm/scripts/rvm
rvm use default
bundle install
bundle exec pod trunk push

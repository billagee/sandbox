#!/bin/bash -l
set -e -x

# jenkins_recreate_rvm_gemset.sh - a script that can be used in a jenkins job
# to recreate an rvm gemset for each run of a rails unit test suite.

# Remove old gemset from previous test run
rvm use ruby-2.2.3
if rvm gemset list | grep my_gemset_name ; then
  rvm gemset delete my_gemset_name --force
fi

# Recreate gemset
rvm use ruby-2.2.3@my_gemset_name --create

# Install gems
gem install bundler --version 1.10.6
bundle install --without production

# Prepare DB for test environment.
# NB: without DISABLE_SPRING=true, this command will encounter an error
# from the spring gem, apparently because a raw bash script running in
# jenkins doesn't provide the terminal environment spring expects.
# See https://github.com/rails/spring/issues/231
DISABLE_SPRING=1 bin/rake db:test:prepare

# Also NB: I've seen comments that db:test:prepare is deprecated? Not sure.
# If ever required, a working replacement for the above line is:
#DISABLE_SPRING=true bin/rake db:migrate RAILS_ENV=test

# Run test suite
rake test


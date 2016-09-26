#!/bin/bash -eux

# Fetches the console log of build 'foo'

# API tokens are available via each user's page, for example:
# https://jenkins.example.com/user/foo/configure

JENKINS_CREDS=foo:YOUR_TOKEN
JENKINS_BASE_URL=https://jenkins.example.com
curl -s --user $JENKINS_CREDS \
  $JENKINS_BASE_URL/job/foo/lastStableBuild/consoleFull > latestStableConsole.txt

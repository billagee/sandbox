#!/bin/bash

# Print the lastSuccessfulBuild values for a job
curl --silent https://YOUR-JENKINS-HOST/job/YOUR-JOB/api/json | jq .lastSuccessfulBuild


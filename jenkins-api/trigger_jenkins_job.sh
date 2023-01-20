#!/bin/bash -eux

export JENKINS_CREDENTIALS=$JENKINS_USER:$JENKINS_TOKEN
export JENKINS_URL=https://xxxx
export JENKINS_JOB_URL=${JENKINS_URL}/${JENKINS_JOB_PATH}
export BUILD_PARAM_NAME=YOUR_REVISION
export BUILD_PARAM_VALUE=${COMMIT_SHA}

export CRUMB_PATH='/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'
export JENKINS_CRUMB_HEADER=$(curl --silent --user "$JENKINS_CREDENTIALS" $JENKINS_URL$CRUMB_PATH)
export CURL_CMD="curl --silent --user $JENKINS_CREDENTIALS -H "$JENKINS_CRUMB_HEADER""

# Triggers a Jenkins build
function launch_jenkins_build() {
    BUILD_RESP_CODE=$($CURL_CMD --silent --write-out %{http_code} \
        -X POST $JENKINS_JOB_URL/build \
        --data-urlencode json='{"parameter": [{"name":"'$BUILD_PARAM_NAME'", "value":"'$BUILD_PARAM_VALUE'"}]}')

    # Verify HTTP response was 201
    expected_resp_code="201"
    if [ ! "$BUILD_RESP_CODE" = "$expected_resp_code" ] ; then
        echo "ERROR: Expected '$expected_resp_code', but got resp code '$BUILD_RESP_CODE'"
        exit 1
    fi
}

# Poll until NEXT_BUILD_NUMBER exists
function wait_for_jenkins_build_to_launch() {
    COUNTER=0
    BUILD_EXISTS=0
    while [  $COUNTER -lt 30 ] ; do
        #echo The counter is $COUNTER
        build_id_check_cmd="$CURL_CMD --silent --write-out %{http_code} $JENKINS_JOB_URL/$NEXT_BUILD_NUMBER/ -o /dev/null"

        #echo "Will use cmd '$build_id_check_cmd'"
        BUILD_EXISTS_RESP=$($build_id_check_cmd)

        #echo "BUILD_EXISTS_RESP was '$BUILD_EXISTS_RESP'"
        if [ "$BUILD_EXISTS_RESP" = "200" ] ; then
            BUILD_EXISTS=1
            break
        fi

        echo "Waiting for Jenkins build to be scheduled..."
        let COUNTER=COUNTER+1
        sleep 1
    done
    if [ ! "$BUILD_EXISTS" = "1" ] ; then
        echo "ERROR: Timed out waiting for Jenkins build to be scheduled!"
        exit 1
    fi
}

# Check that the build has the correct param value
function check_build_param_value() {
    ACTUAL_BUILD_PARAM_VALUE=$($JSON_API_CMD | jq -r '.actions[0] .parameters[0] .value')
    #echo "The build's param value is '$ACTUAL_BUILD_PARAM_VALUE'"
    EXPECTED_BUILD_PARAM_VALUE=$BUILD_PARAM_VALUE
    if [ ! "$ACTUAL_BUILD_PARAM_VALUE" = "$EXPECTED_BUILD_PARAM_VALUE" ] ; then
        echo "ERROR: Expected '$EXPECTED_BUILD_PARAM_VALUE', but the build has tag param value '$ACTUAL_BUILD_PARAM_VALUE'"
        exit 1
    fi
}

# Get NEXT_BUILD_NUMBER (most recent build + 1)
NEXT_BUILD_NUMBER=$($CURL_CMD --silent -X POST $JENKINS_JOB_URL/api/json | jq .nextBuildNumber)
$CURL_CMD --silent -X POST $JENKINS_JOB_URL/api/json | jq .nextBuildNumber
JSON_API_CMD="$CURL_CMD --silent -X POST $JENKINS_JOB_URL/$NEXT_BUILD_NUMBER/api/json"
echo "Next build number is '$NEXT_BUILD_NUMBER'"

launch_jenkins_build
wait_for_jenkins_build_to_launch
check_build_param_value

echo "Build URL: $JENKINS_JOB_URL/$NEXT_BUILD_NUMBER/"

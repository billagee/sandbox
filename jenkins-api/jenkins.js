// Print the lastSuccessfulBuild values for a job

var https = require('https');

var options = {
  hostname: 'YOUR-JENKINS-HOST',
  port: 443,
  path: '/job/YOUR-JOB/api/json',
  auth: "USER:PASS"
};
https.get(options, function(res) {
  console.log("statusCode: ", res.statusCode);
  console.log("headers: ", res.headers);

  var body = '';
  res.on('data', function(d) {
    body += d;
  });

  res.on('end', function() {
    var parsed = JSON.parse(body);
    process.stdout.write(JSON.stringify(parsed.lastSuccessfulBuild));
  });

}).on('error', function(e) {
  console.error(e);
});


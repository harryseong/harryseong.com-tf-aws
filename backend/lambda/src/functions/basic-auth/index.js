'use strict';
const ssmAccess = require('/opt/nodejs/ssm-access');

exports.handler = (event, context, callback) => {
    // Get request and request headers
    const request = event.Records[0].cf.request;
    const headers = request.headers;

    // Configure authentication from SSM parameter store
    const [authUser, authPass] = [
        process.env.SSM_PARAM_BASIC_AUTH_USERNAME,
        process.env.SSM_PARAM_BASIC_AUTH_PASSWORD
    ];

    // Construct the Basic Auth string
    const authString = 'Basic ' + new Buffer(authUser + ':' + authPass).toString('base64');

    // Require Basic authentication
    if (typeof headers.authorization == 'undefined' || headers.authorization[0].value != authString) {
        const body = 'Unauthorized';
        const response = {
            status: '401',
            statusDescription: 'Unauthorized',
            body: body,
            headers: {
                'www-authenticate': [{ key: 'WWW-Authenticate', value: 'Basic' }]
            },
        };
        callback(null, response);
    }

    // Continue request processing if authentication passed
    callback(null, request);
};
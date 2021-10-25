const AWS = require("aws-sdk");
const ssm = new AWS.SSM({region: 'us-east-1'});

// Fetch parameter from SSM parameter store.
const getParameter = async (paramName, decrypt) => {
    return await ssm.getParameter({Name: paramName, WithDecryption: decrypt}).promise()
        .then(rsp => {
            return rsp.Parameter;
        }).catch(error => {
            console.error(error.stack);
            return error;
        });
};

// Fetch multiple parameters from SSM parameter store.
const getParameters = async (paramNames, decrypt) => {
    return await ssm.getParameters({Names: paramNames, WithDecryption: decrypt}).promise()
        .then(rsp => {
            return rsp.Parameters;
        }).catch(error => {
            console.error(error.stack);
            return error;
        });
};

module.exports = {
    getParameter: getParameter,
    getParameters: getParameters
};

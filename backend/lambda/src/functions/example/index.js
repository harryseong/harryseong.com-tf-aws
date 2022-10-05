'use strict';

exports.handler = async (event, context) => {

    const name = event.queryStringParameters.name
    try {
        console.log('Running example API endpoint Lambda function.');
        console.log(`Name: ${name}`);
        return `Hello, ${name}. This is an example API endpoint response.`;
    } catch (error) {
        console.error(error.stack);
        return error;
    }
};

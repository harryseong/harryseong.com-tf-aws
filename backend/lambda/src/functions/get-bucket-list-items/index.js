'use strict';
const AWS = require('aws-sdk');
AWS.config.update({ region: process.env.AWS_REGION });

exports.handler = async (event) => {

    const docClient = new AWS.DynamoDB.DocumentClient();

    const params = {
        TableName: process.env.DYNAMODB_TABLE,
    };

    try {
        console.log('Querying all bucket list items.');
        const data = await docClient.scan(params).promise();
        console.log(`Count: ${data.Count}, Scanned Count: ${data.ScannedCount}`);
        return data.Items;
    } catch (error) {
        console.error(error.stack);
        return error;
    }
};

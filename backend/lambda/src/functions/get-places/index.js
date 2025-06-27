'use strict';;
const { DynamoDBDocument } = require('@aws-sdk/lib-dynamodb');
const { DynamoDB } = require('@aws-sdk/client-dynamodb');

exports.handler = async (event) => {

    const docClient = DynamoDBDocument.from(new DynamoDB());

    const params = {
        TableName: process.env.DYNAMODB_TABLE,
    };

    try {
        console.log('Querying all places.');
        const data = await docClient.scan(params);
        console.log(`Count: ${data.Count}, Scanned Count: ${data.ScannedCount}`);
        return data.Items;
    } catch (error) {
        console.error(error.stack);
        return error;
    }
};

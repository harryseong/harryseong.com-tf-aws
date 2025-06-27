const { SNS } = require('@aws-sdk/client-sns');
const sns = new SNS({
    region: 'us-east-1'
});

const publishMessage = async (message) => {
    var params = {
        Message: message,
        TopicArn: 'arn:aws:sns:us-east-1:552566233886:weather-updates-topic'
    };

    return await sns.publish(params)
        .then(rsp => {
            console.log('Message successfully published to SNS topic');
            return message;
        }).catch(error => {
            console.error(error.stack);
            return error;
        });
};

module.exports = {
    publishMessage: publishMessage
};
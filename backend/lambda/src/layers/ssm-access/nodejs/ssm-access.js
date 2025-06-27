const { SSMClient, GetParameterCommand, GetParametersCommand } = require("@aws-sdk/client-ssm");

const ssm = new SSMClient();  // Optional: pass config if needed

// Fetch single parameter
const getParameter = async (paramName, decrypt = true) => {
    try {
        const command = new GetParameterCommand({
            Name: paramName,
            WithDecryption: decrypt
        });
        const rsp = await ssm.send(command);
        return rsp.Parameter;
    } catch (error) {
        console.error(error.stack);
        return error;
    }
};

// Fetch multiple parameters
const getParameters = async (paramNames, decrypt = true) => {
    try {
        const command = new GetParametersCommand({
            Names: paramNames,
            WithDecryption: decrypt
        });
        const rsp = await ssm.send(command);
        return rsp.Parameters;
    } catch (error) {
        console.error(error.stack);
        return error;
    }
};

module.exports = {
    getParameter,
    getParameters
};
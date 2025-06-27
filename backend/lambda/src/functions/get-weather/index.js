'use strict';
const axios = require('/opt/nodejs/node_modules/axios');
const {getParameter} = require('/opt/nodejs/ssm-access');

let appid;

exports.handler = async (event, context) => {

    // Fetch Open Weather Map parameter from SSM parameter store if not cached yet.
    if (appid === undefined) {
        console.log("Open Weather Map parameter not available from cache; fetching from SSM Param Store.")
        await getOpenWeatherMapParameter();
    } else {
        console.log("Open Weather Map parameter already available from cache.")
    }

    const units = event.queryStringParameters.units;
    const zip = event.queryStringParameters.zip;

    return await getCurrentWeather(appid, units, zip);
};

const getOpenWeatherMapParameter = async () => {
    // Fetch Open Weather Map parameter from SSM parameter store.
    appid = await getParameter(process.env.SSM_PARAM_OPEN_WEATHER_MAP_APP_ID, true)
        .then(param => { return param.Value });
}

// Fetch current weather.
const getCurrentWeather = async (appid, units, zip) => {

    // Set request params.
    const config = {
        params: { appid, units, zip }
    };

    return await axios.get(process.env.OPEN_WEATHER_MAP_API_URL_WEATHER, config)
        .then(res => {
            return res.data;
        }).catch(error => {
            console.error(error.stack);
            return error;
        });
};
'use strict';
const axios = require('/opt/nodejs/node_modules/axios');
const ssmAccess = require('/opt/nodejs/ssm-access');
const snsAccess = require('/opt/nodejs/sns-access');

exports.handler = async (event, context) => {
    // Fetch Open Weather Map parameter from SSM parameter store.
    const appid = await ssmAccess.getParameter(process.env.SSM_PARAM_OPEN_WEATHER_MAP_APP_ID, true)
        .then(param => { return param.Value });
    const units = 'imperial';
    const zip = '55362';

    const rsp = await getCurrentWeather(appid, units, zip);
    const message = `Today's weather in ${rsp.name}:
    [${rsp.weather[0].description}]
    Current: ....... ${rsp.main.temp}°F
    Feels Like: .... ${rsp.main.feels_like}°F
    Low: ........... ${rsp.main.temp_min}°F
    High: .......... ${rsp.main.temp_max}°F`
    snsAccess.publishMessage(message);
};

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
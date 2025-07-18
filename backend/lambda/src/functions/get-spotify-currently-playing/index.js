'use strict';
const axios = require('/opt/nodejs/node_modules/axios');
const qs = require('/opt/nodejs/node_modules/querystring');
const {getParameters} = require('/opt/nodejs/ssm-access');

const [ID, SECRET, REFRESH_TOKEN] = [
    process.env.SSM_PARAM_SPOTIFY_CLIENT_ID,
    process.env.SSM_PARAM_SPOTIFY_CLIENT_SECRET,
    process.env.SSM_PARAM_SPOTIFY_CLIENT_REFRESH_TOKEN
];
let spotifyClientId, spotifyClientSecret, spotifyClientRefreshToken;

exports.handler = async (event, context) => {

    // Fetch Spotify parameters from SSM parameter store if not cached yet.
    if (spotifyClientId === undefined || 
        spotifyClientSecret === undefined || 
        spotifyClientRefreshToken === undefined) {
        console.log("Spotify parameters not available from cache; fetching from SSM Param Store.")
        await getSpotifyParameters();
    } else {
        console.log("Spotify parameters already available from cache.")
    }

    // Fetch Spotify access token and use to fetch currently playing Spotify song.
    return await getSpotifyAccessToken(spotifyClientId, spotifyClientSecret, spotifyClientRefreshToken)
        .then(accessToken => {
            return getSpotifyCurrentSong(accessToken);
        }).catch(error => {
            console.error(error.trace);
            return error;
        });
};

// Fetch Spotify parameters from SSM parameter store.
const getSpotifyParameters = async () => {
    await getParameters([ID, SECRET, REFRESH_TOKEN], true)
        .then(params => {
            params.forEach(param => {
                switch (param.Name) {
                    case ID:
                        spotifyClientId = param.Value;
                        break;
                    case SECRET:
                        spotifyClientSecret = param.Value;
                        break;
                    case REFRESH_TOKEN:
                        spotifyClientRefreshToken = param.Value;
                        break;
                }
            });
        });
}

// Fetch Spotify access token.
const getSpotifyAccessToken = async (spotifyClientId, spotifyClientSecret, spotifyClientRefreshToken) => {

    // Set request headers.
    const config = {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
    };

    // Set request body.
    const data = qs.stringify({
        grant_type: 'refresh_token',
        refresh_token: spotifyClientRefreshToken,
        client_id: spotifyClientId,
        client_secret: spotifyClientSecret
    });

    return await axios.post(process.env.SPOTIFY_API_URL_AUTH_TOKEN, data, config)
        .then(res => {
            return res.data.access_token;
        }).catch(error => {
            console.error(error.stack);
            return error;
        });
};

// Fetch currently playing song.
const getSpotifyCurrentSong = async (accessToken) => {

    // Set request headers.
    const config = {
        headers: { 'Authorization': `Bearer ${accessToken}` }
    };

    return await axios.get(process.env.SPOTIFY_API_URL_CURRENT_SONG, config)
        .then(res => {
            return res.data;
        }).catch(error => {
            console.error(error.stack);
            return error;
        });
};
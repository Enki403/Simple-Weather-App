const API_URL = process.env.OPENWEATHERMAP_URL;
const API_KEY = process.env.OPENWEATHERMAP_API_KEY;

const {expressRequest, expressResponse} = require("express");

const axios = require("axios");
const { param } = require("../routes/weather");

const getWeatherByCityName = async(expressRequest, expressResponse = expressResponse) => {
    
    try{
        
        const units = expressRequest.query.units || 'imperial';

        const OpenWeatherParams = {
            q : expressRequest.query.cityName,
            units,
            appid: API_KEY,
        };
        
        const OpenWeatherResponse = await axios
            .get(`${ API_URL }weather`, { params : OpenWeatherParams })        
            .catch((OpenWeatherError)=>{
                const { status, data } = OpenWeatherError.response;
                
                parsedError = {
                    status: data.cod,
                    statusText: data.message
                }

                apiError = new Error(JSON.stringify(parsedError));
                apiError.code= status;
                
                throw( apiError );
            }
        );
        const { status, statusText, data } = OpenWeatherResponse;

        const keyWeatherInformation = {
            weather: data.weather,
            timestamp: data.dt,
            information: data.main
        };
        return expressResponse.status(status).json({
            statusText,
            data: keyWeatherInformation
        });

    }catch( error ){
        
        const statusCode = error.code || 500;

        if(statusCode != 500){
            error.message = JSON.parse(error.message);
        }

        return expressResponse.status(statusCode).json({
            statusText: error.message.statusText
        });
    }
};

const getWeatherByCoordinates = async(expressRequest, expressResponse = expressResponse) => {
    
    try{
        
        const units = expressRequest.query.units || 'imperial';

        const OpenWeatherParams = {
            lat : expressRequest.query.lat,
            lon : expressRequest.query.lng,
            units,
            appid: API_KEY,
        };
        
        const OpenWeatherResponse = await axios
            .get(`${ API_URL }weather`, { params : OpenWeatherParams })        
            .catch((OpenWeatherError)=>{
                const { status, data } = OpenWeatherError.response;
                
                parsedError = {
                    status: data.cod,
                    statusText: data.message
                }

                apiError = new Error(JSON.stringify(parsedError));
                apiError.code= status;
                
                throw( apiError );
            }
        );
        const { status, statusText, data } = OpenWeatherResponse;

        const location = {
            cityName: data.name,
            country: data.sys.country,
            sunrise: data.sys.sunrise,
            sunset: data.sys.sunset
        };

        const keyWeatherInformation = {
            timestamp: data.dt,
            location,
            weather: data.weather,
            information: data.main
        };
        return expressResponse.status(status).json({
            statusText,
            data: keyWeatherInformation
        });

    }catch( error ){
        const statusCode = error.code || 500;

        if(statusCode != 500){
            error.message = JSON.parse(error.message);
        }

        return expressResponse.status(statusCode).json({
            statusText: error.message.statusText
        });
    }
};

module.exports = {
    getWeatherByCityName,
    getWeatherByCoordinates
}
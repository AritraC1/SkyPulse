require('dotenv').config();

const express = require('express');
const axios = require('axios');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT_NUMBER || 5000;

// Fetching Data from API
app.get('/weather', async (req, res) => {
    const {location} = req.query;
    const apiKey = process.env.API_KEY;
    const url = `https://api.openweathermap.org/data/2.5/weather?q=${location}&appid=${apiKey}`;

    try {
        const response = await axios.get(url);
        
        const data = response.data;
        const weatherInfo = {
            location: data.name,
            temperature: (data.main.temp - 273.15).toFixed(1), // Kelvin to Celcius
            description: data.weather[0].description,
            humidity: data.main.humidity,
            windSpeed: data.wind.speed,
        };
        res.json(weatherInfo);
    } catch (error) {
        res.status(500).send('Error fetching weather data');
    }
})

// Server start
app.listen(PORT, () => {
    console.log(`Server is running on Port Number: ${PORT}`);
});
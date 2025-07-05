// src/App.js
import React, { useState } from 'react';
import axios from 'axios';
import './Weather.css';

function App() {
  const [city, setCity] = useState('');
  const [weather, setWeather] = useState(null);
  const [error, setError] = useState('');

  const API_KEY = '98ae515121f8a4794db0db0859503063'; // 🔁 Replace with your actual OpenWeatherMap API key

  const fetchWeather = () => {
    if (!city) {
      setError('Please enter a city name');
      setWeather(null);
      return;
    }

    const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${API_KEY}`;

    axios.get(url)
      .then(response => {
        setWeather(response.data);
        setError('');
      })
      .catch(err => {
        setWeather(null);
        setError('City not found. Please try again.');
      });
  };

  return (
    <div className="weather-container">
      <h1>Weather App 🌦️</h1>
      <div className="search-box">
        <input
          type="text"
          placeholder="Enter city name"
          value={city}
          onChange={e => setCity(e.target.value)}
        />
        <button onClick={fetchWeather}>Get Weather</button>
      </div>
      {error && <p className="error">{error}</p>}
      {weather && (
        <div className="weather-result">
          <h2>{weather.name}</h2>
          <p><strong>Temperature:</strong> {weather.main.temp} °C</p>
          <p><strong>Humidity:</strong> {weather.main.humidity} %</p>
          <p><strong>Condition:</strong> {weather.weather[0].description}</p>
        </div>
      )}
    </div>
  );
}

export default App;

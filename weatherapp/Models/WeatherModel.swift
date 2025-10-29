//
//  WeatherModel.swift
//  weatherapp
//
//  Created by Elbar on 27/10/25.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: String
    let description: String
    let feelsLike: String
    let humidity: String
    let iconCode: String
    let pressure: String
    let windSpeed: String 
    
    init(weatherData: WeatherData) {
        self.cityName = weatherData.name
        self.temperature = "\(Int(weatherData.main.temp))°C"
        self.description = weatherData.weather.first?.description.capitalized ?? ""
        self.feelsLike = "Feels like \(Int(weatherData.main.feelsLike))°C"
        self.humidity = "Humidity: \(weatherData.main.humidity)%"
        self.iconCode = weatherData.weather.first?.icon ?? ""
        self.pressure = "\(weatherData.main.pressure) hPa"
        self.windSpeed = "\(weatherData.wind.speed) m/s"     
    }
}

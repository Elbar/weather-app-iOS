//
//  WeatherData.swift
//  weatherapp
//
//  Created by Elbar on 27/10/25.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let humidity: Int
    let pressure: Int
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
        case pressure
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}


struct Sys: Codable {
    let country: String
    let sunrise: Int
    let sunset: Int
}

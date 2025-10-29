//
//  WeatherService.swift
//  weatherapp
//
//  Created by Elbar on 27/10/25.
//

import Foundation


import Foundation

// Enum для ошибок
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class WeatherService {
    
    static let shared = WeatherService()
    private init() {}
    
    func fetchWeather(city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        
        let urlString = "\(Constants.baseURL)?q=\(city)&appid=\(Constants.apiKey)&units=metric"
        
        guard let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        
        task.resume()
    }
}

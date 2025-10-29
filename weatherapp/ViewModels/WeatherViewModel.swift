//
//  WeatherViewModel.swift
//  weatherapp
//
//  Created by Elbar on 27/10/25.
//


import Foundation

class WeatherViewModel {
    
    private(set) var weatherModel: WeatherModel?
    
    var onWeatherUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var isLoading: ((Bool) -> Void)?
    
    func loadWeather(for city: String) {
        
        UserDefaultsManager.shared.saveLastCity(city)

        DispatchQueue.main.async{
            self.isLoading?(true)
        }
        
        WeatherService.shared.fetchWeather(city: city) { [weak self] result in
            
            DispatchQueue.main.async{
                self?.isLoading?(false)
            }
            
            switch result {
            case .success(let weatherData):
                self?.weatherModel = WeatherModel(weatherData: weatherData)
                
                DispatchQueue.main.async {
                    self?.onWeatherUpdated?()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func getTemperature() -> String {
        return weatherModel?.temperature ?? "--"
    }
    
    func getCityName() -> String {
        return weatherModel?.cityName ?? "Unknown"
    }
    
    func getDescription() -> String {
        return weatherModel?.description ?? ""
    }
    
    func getFeelsLike() -> String {
        return weatherModel?.feelsLike ?? ""
    }
    
    func getHumidity() -> String {
        return weatherModel?.humidity ?? ""
    }
    
    func getIconCode() -> String {
        return weatherModel?.iconCode ?? ""
    }
    
    func getPressure() -> String {
        return weatherModel?.pressure ?? "--"
    }

    func getWindSpeed() -> String {
        return weatherModel?.windSpeed ?? "--"
    }
}

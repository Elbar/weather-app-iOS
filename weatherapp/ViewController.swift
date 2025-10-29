//
//  ViewController.swift
//  weatherapp
//
//  Created by Elbar on 27/10/25.
//

import UIKit


class ViewController: UIViewController {
    
    let viewModel = WeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupBindings()
        testViewModel()
    }
    
    func setupBindings() {
        // Подписываемся на обновления
        viewModel.onWeatherUpdated = { [weak self] in
            print("✅ Погода обновлена!")
            print("Город: \(self?.viewModel.getCityName() ?? "")")
            print("Температура: \(self?.viewModel.getTemperature() ?? "")")
            print("Описание: \(self?.viewModel.getDescription() ?? "")")
        }
        
        viewModel.onError = { error in
            print("❌ Ошибка: \(error)")
        }
        
        viewModel.isLoading = { loading in
            print(loading ? "🔄 Загрузка..." : "✓ Загрузка завершена")
        }
    }
    
    func testViewModel() {
        viewModel.loadWeather(for: "London")
    }
}

//
//  WeatherViewController.swift
//  weatherapp
//
//  Created by Elbar on 27/10/25.
//


import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = WeatherViewModel()
    
    // MARK: - UI Elements
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter city name"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 70, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "cloud.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let additionalInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    private let pressureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let windLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pressureContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let windContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Activity Indicator
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        
        let lastCity = UserDefaultsManager.shared.getLastCity()
        viewModel.loadWeather(for: lastCity)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self
        
        pressureContainerView.addSubview(pressureLabel)
        windContainerView.addSubview(windLabel)
    
        additionalInfoStackView.addArrangedSubview(pressureContainerView)
        additionalInfoStackView.addArrangedSubview(windContainerView)
        
        view.addSubview(searchBar)
        view.addSubview(cityLabel)
        view.addSubview(weatherIconImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(separatorView)
        view.addSubview(feelsLikeLabel)
        view.addSubview(humidityLabel)
        view.addSubview(additionalInfoStackView)
        view.addSubview(activityIndicator)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // SearchBar
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // City Label
            cityLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 40),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Weather Icon
            weatherIconImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            weatherIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 120),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Temperature Label
            temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Description Label
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Separator
            separatorView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            // Feels Like Label
            feelsLikeLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 25),
            feelsLikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Humidity Label
            humidityLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 8),
            humidityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Additional Info Stack
            additionalInfoStackView.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 25),
            additionalInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            additionalInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            additionalInfoStackView.heightAnchor.constraint(equalToConstant: 80),
            
            // Pressure Container
            pressureContainerView.widthAnchor.constraint(equalTo: additionalInfoStackView.widthAnchor, multiplier: 0.45),
            
            // Wind Container
            windContainerView.widthAnchor.constraint(equalTo: additionalInfoStackView.widthAnchor, multiplier: 0.45),
            
            // Pressure Label inside container
            pressureLabel.topAnchor.constraint(equalTo: pressureContainerView.topAnchor, constant: 12),
            pressureLabel.leadingAnchor.constraint(equalTo: pressureContainerView.leadingAnchor, constant: 8),
            pressureLabel.trailingAnchor.constraint(equalTo: pressureContainerView.trailingAnchor, constant: -8),
            pressureLabel.bottomAnchor.constraint(equalTo: pressureContainerView.bottomAnchor, constant: -12),
            
            // Wind Label inside container
            windLabel.topAnchor.constraint(equalTo: windContainerView.topAnchor, constant: 12),
            windLabel.leadingAnchor.constraint(equalTo: windContainerView.leadingAnchor, constant: 8),
            windLabel.trailingAnchor.constraint(equalTo: windContainerView.trailingAnchor, constant: -8),
            windLabel.bottomAnchor.constraint(equalTo: windContainerView.bottomAnchor, constant: -12),
            
            // Activity Indicator
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        viewModel.onWeatherUpdated = { [weak self] in
            self?.updateUI()
        }
        
        viewModel.onError = { [weak self] error in
            self?.showError(message: error)
        }
        
        viewModel.isLoading = { [weak self] isLoading in
            if isLoading {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    // MARK: - Update UI
    private func updateUI() {
        cityLabel.text = viewModel.getCityName()
        temperatureLabel.text = viewModel.getTemperature()
        descriptionLabel.text = viewModel.getDescription()
        feelsLikeLabel.text = viewModel.getFeelsLike()
        humidityLabel.text = viewModel.getHumidity()
        
        pressureLabel.text = "💨\nPressure\n\(viewModel.getPressure())"
        windLabel.text = "🌬️\nWind\n\(viewModel.getWindSpeed())"
          
        loadWeatherIcon()
    }
    
    private func loadWeatherIcon() {
        let iconCode = viewModel.getIconCode()
        let iconURL = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
        
        guard let url = URL(string: iconURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.weatherIconImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    // MARK: - Error Handling
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

// MARK: - UISearchBarDelegate
extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let city = searchBar.text, !city.isEmpty else { return }
        viewModel.loadWeather(for: city)
    }
}

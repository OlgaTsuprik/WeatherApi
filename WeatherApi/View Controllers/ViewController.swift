//
//  ViewController.swift
//  WeatherApi
//
//  Created by Оля on 29.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    // MARK: IB Actions
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [weak self] city in
            guard let self = self else { return }
                self.networkWeatherManager.fetchCurrentWeather(forCity: city)
        }
    }
    
    // MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterface(weather: currentWeather)
        }
        networkWeatherManager.fetchCurrentWeather(forCity: "London")
    }
    
    // MARK: Methods
    func updateInterface(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}


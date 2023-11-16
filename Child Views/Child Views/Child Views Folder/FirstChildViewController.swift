//
//  FirstChildViewController.swift
//  Child Views
//
//  Created by Tejas Kashid on 05/11/23.
//

import UIKit

class FirstChildViewController: UIViewController {
    
    
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        
        fetchData()
    }
    
    func fetchData() {
        let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=65a7aea3e395474187a20653220504&q=india&aqi=no")
        let dataTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else {
                print("Error accessing data with URL")
                return
            }
            var fullWeatherData: WeatherData?
            do {
                try fullWeatherData = JSONDecoder().decode(WeatherData.self, from: data)
            }
            catch {
                print("Error decoding JSON object into struct")
            }
                DispatchQueue.main.async {
                    self.updateLabel?.text = "Updated: \(fullWeatherData!.current.last_updated)"
                    self.regionLabel?.text = "Region: \(fullWeatherData!.location.region)"
                    self.countryLabel?.text = "Country: \(fullWeatherData!.location.country)"
                    self.temperatureLabel?.text = "Temperature(Celcius): \(fullWeatherData!.current.temp_c)"
                    self.windLabel?.text = "Wind(Km/Hr): \(fullWeatherData!.current.wind_kph)"
                    self.humidityLabel?.text = "Humidity: \(fullWeatherData!.current.humidity)"
                
            }
        }
        dataTask.resume()
    }


}

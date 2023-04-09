//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Satya Swaroop on 08/04/23.
//

import Foundation
import UIKit

protocol WeatherViewModelProtocol {
    func fetchWeatherDataFromService()
    func fetchCityDataFromService(cityName: String) -> Void
    func getWeatherData()
    func getTheIcon(icon: String)-> String
}

class WeatherViewModel: WeatherViewModelProtocol {
    
    // MARK: - Properties
    private var service: WeatherService
    var city: [City] = [City]()
    var weatherData: WeatherData?
    var onDataAvailable : ((_ data: WeatherData) -> ())?
    
    // MARK: - Initilizer
    init() {
        service = WeatherService()
    }
    
    // MARK: - get weather data from server
    func fetchWeatherDataFromService() {
        let cityElement = self.city[0]
        print(cityElement[0])
        
        service.fetchData(lat: cityElement[0].lat, lon: cityElement[0].lon){
            result in
            switch result {
            case .success(let value):
                // Handle success case with city data
                self.weatherData = value
                self.onDataAvailable?(self.weatherData!)
                
                break;
            case .failure(let error):
                // Handle failure case with error
                print("Error: \(error.localizedDescription)")
                break;
            }
        }
        
    }
    
    // MARK: - get city data from server
    func fetchCityDataFromService(cityName: String) -> Void {
        service.fetchCityData(cityName: cityName) { result in
            switch result {
            case .success(let value):
                // Handle success case with city data
                if (value.count != 0) {
                    self.city.append(value)
                    self.getWeatherData()
                }
                //print(self.city)
                break;
            case .failure(let error):
                // Handle failure case with error
                print("Error: \(error.localizedDescription)")
                break;
            }
        }
    }
    
    // MARK: - get weather data from server
    func getWeatherData() {
        fetchWeatherDataFromService()
    }
    
    // MARK: - get icon image from the code
    func getTheIcon(icon: String)-> String  {
        switch icon {
        case "01d" :
            return Images.ONE_D
        case "02d" :
            return Images.TWO_D
        case "03d" :
            return Images.THREE_D
        case "04d" :
            return Images.FOUR_D
        case "09d" :
            return Images.NINE_D
        case "10d" :
            return Images.TEN_D
        default:
            return ""
        }
        
    }
}

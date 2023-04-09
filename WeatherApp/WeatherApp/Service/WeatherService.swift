//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Satya Swaroop on 08/04/23.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchData(lat: Double, lon: Double, completionHandler: @escaping (Result<WeatherData,Error>) -> Void)
    func fetchCityData(cityName: String, completionHandler: @escaping (Result<City,Error>) -> Void)
}

class WeatherService :BaseService, WeatherServiceProtocol {
    
    
    func createGETAPI(urlString: String, method:String) -> URLRequest {
        // Create URL
        let url = URL(string: APIConstants.BASEURL+urlString)
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = method
        return request
    }
    
    // MARK: - fetch Weather data from service
    func fetchData(lat: Double, lon: Double, completionHandler: @escaping (Result<WeatherData,Error>) -> Void) {
        let urlString = APIConstants.BASEURL+"data/2.5/weather?lat=\(lat)&lon=\(lon)1&appid=\(APIConstants.APIKEY)"
        print(urlString)
        httpRequest(urlString: urlString, method: .get) { (result: Result<WeatherData, APIError>) in
            switch result {
            case .success(let post):
                print(post)
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
    
    // MARK: - fetch City data from service
    func fetchCityData(cityName: String, completionHandler: @escaping (Result<City,Error>) -> Void) {
        let urlString = APIConstants.BASEURL+"/geo/1.0/direct?q=\(cityName)&limit=5&appid=\(APIConstants.APIKEY)"
        httpRequest(urlString: urlString, method: .get) { (result: Result<City, APIError>) in
            switch result {
            case .success(let city):
                completionHandler(.success(city))
            case .failure(let error):
                print("Error: \(error)")
                completionHandler(.failure(error))
            }
        }
    }
}

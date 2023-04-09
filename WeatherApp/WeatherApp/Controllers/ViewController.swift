//
//  ViewController.swift
//  WeatherApp
//
//  Created by Satya Swaroop on 08/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    private var weatherViewModel: WeatherViewModel
    
    // MARK: - Init
    required init?(coder: NSCoder) {
        weatherViewModel = WeatherViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle methoods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Search for city"
        //weatherViewModel.fetchDataFromService()
        self.searchBar.searchTextField.borderStyle = .none
        self.searchBar.searchTextField.layer.cornerRadius = 10
        self.searchBar.searchTextField.backgroundColor = .clear
        
        self.weatherViewModel.onDataAvailable = {[weak self]
            (data) in
            if let weakSelf = self {
                weakSelf.updateData(data: data)
            }
        }
    }
    
    // MARK: - Update UI based on server data
    func updateData(data: WeatherData) {
        let icon =  self.weatherViewModel.getTheIcon(icon: data.weather[0].icon)
        DispatchQueue.main.async {
            self.titleLabel.text = data.name
            self.weatherLabel.text = String(data.weather.count)
            self.descriptionLabel.text = data.weather.description
            self.iconImgView.image = UIImage(named: icon)
        }
    }
}

// MARK: - Search bar related
extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        weatherViewModel.fetchCityDataFromService(cityName: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}

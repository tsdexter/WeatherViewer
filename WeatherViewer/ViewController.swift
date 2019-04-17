//
//  ViewController.swift
//  WeatherViewer
//
//  Created by Thomas Dexter on 2019-04-15.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add view for data
        view.addSubview(dataView)
        
        view.addSubview(headerLabel)
        view.addSubview(searchButton)
        view.addSubview(searchField)
        
        // add views that hold weather data into data view
        dataView.addSubview(currentLabel)
        dataView.addSubview(temperatureLabel)
        dataView.addSubview(temperatureValueLabel)
        dataView.addSubview(descriptionValueLabel)
        dataView.addSubview(descriptionLabel)
        dataView.addSubview(forecastsLabel)
        dataView.addSubview(forecastHighLabel)
        dataView.addSubview(forecastHighValueLabel)
        dataView.addSubview(forecastLowLabel)
        dataView.addSubview(forecastLowValueLabel)
        dataView.addSubview(forecastDescriptionLabel)
        dataView.addSubview(forecastDescriptionValueLabel)
        
        toggleDisplay(isHidden: true)
        
        view.setNeedsUpdateConstraints()
    }

    lazy var headerLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.text = "Weather Viewer"
        view.font = view.font.withSize(36)
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var searchField: UITextField! = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.placeholder = "City"
        view.textAlignment = .left
        view.font = .systemFont(ofSize: 24)
        
        return view
    }()
    
    lazy var searchButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.setTitle("Search", for: .normal)
        view.backgroundColor = UIColor.white
        view.setTitleColor(UIColor.black, for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 15.0, bottom: 5.0, right: 15.0)
        view.addTarget(self, action: #selector(onSearchClicked), for: .touchDown)
        
        return view
    }()
    
    @objc func onSearchClicked() {
        guard let location = searchField.text else {
            print("Error getting text")
            return
        }
        let apiManager:ApiManager = ApiManager()
        
        DispatchQueue.global(qos: .userInitiated).async {
            apiManager.getWeatherData(location: location, success: {(data) -> Void in
                guard let weatherData = data else {
                    print("Error getting weather data")
                    return
                }
                
                DispatchQueue.main.async {
                    self.temperatureValueLabel.text = String(weatherData.currentTemperature) + "°C"
                    self.descriptionValueLabel.text = weatherData.description
                    
                    // add tomorrows forecast
                    self.forecastHighValueLabel.text = String(weatherData.forecasts[0].highTemperature) + "°C"
                    self.forecastLowValueLabel.text = String(weatherData.forecasts[0].lowTemperature) + "°C"
                    self.forecastDescriptionValueLabel.text = weatherData.forecasts[0].description
                    
                    self.toggleDisplay(isHidden: false)
                }
                
            }, failure: {() -> Void in
                DispatchQueue.main.async {
                    self.showMessage(message: "Failed to get weather data, please try again.")
                }
            })
        }
    }
    
    private func showMessage(message: String) {
        let rect = CGRect(x: self.view.frame.size.width / 2 - 150, y: self.view.frame.size.height / 2 - 100, width: 300, height: 45)
        
        let toastLabel = UILabel(frame: rect)
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 1.0
        toastLabel.alpha = 1
        toastLabel.numberOfLines = 0
        toastLabel.text = message
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, animations: {
            toastLabel.alpha = 0
        })
    }
    
    private func toggleDisplay(isHidden: Bool) {
        dataView.isHidden = isHidden
    }
    
    func createLabel(text: String) -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = text
        view.font = view.font.withSize(20)
        return view
    }
    
    // create view to hold api data
    lazy var dataView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var temperatureLabel: UILabel! = {
        return createLabel(text: "Temperature:")
    }()
    
    lazy var temperatureValueLabel: UILabel! = {
        return createLabel(text: "25°C")
    }()
    
    lazy var descriptionLabel: UILabel! = {
        return createLabel(text: "Description:")
    }()
    
    lazy var descriptionValueLabel: UILabel! = {
        return createLabel(text: "Sunny")
    }()
    
    // assignment 4 UI
    lazy var currentLabel: UILabel! = {
        let label = createLabel(text: "Current")
        label.font = label.font.withSize(30)
        return label
    }()
    
    lazy var forecastsLabel: UILabel! = {
        let label = createLabel(text: "Tomorrow")
        label.font = label.font.withSize(30)
        return label
    }()
    
    lazy var forecastHighLabel: UILabel! = {
        createLabel(text: "High:")
    }()
    lazy var forecastLowLabel: UILabel! = {
        createLabel(text: "Low:")
    }()
    lazy var forecastHighValueLabel: UILabel! = {
        createLabel(text: "100°C")
    }()
    lazy var forecastLowValueLabel: UILabel! = {
        createLabel(text: "-100°C")
    }()
    lazy var forecastDescriptionLabel: UILabel! = {
        createLabel(text: "Description:")
    }()
    lazy var forecastDescriptionValueLabel: UILabel! = {
        createLabel(text: "Not so nice 🤷‍♂️")
    }()
    
    override func updateViewConstraints() {
        let margins = view.layoutMarginsGuide
        
        dataView.widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
        
        headerLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15).isActive = true
        headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        searchField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20).isActive = true
        searchField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
        
        searchButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 5).isActive = true
        
        // assignment 4 UI
        currentLabel.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20).isActive = true
        currentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: currentLabel.bottomAnchor, constant: 20).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureValueLabel.topAnchor.constraint(equalTo: currentLabel.bottomAnchor, constant: 20).isActive = true
        temperatureValueLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionValueLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10).isActive = true
        descriptionValueLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        
        // assignment 4 UI
        forecastsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        forecastsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        forecastHighLabel.topAnchor.constraint(equalTo: forecastLowLabel.bottomAnchor, constant: 10).isActive = true
        forecastHighLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        forecastHighValueLabel.topAnchor.constraint(equalTo: forecastLowLabel.bottomAnchor, constant: 10).isActive = true
        forecastHighValueLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        
        forecastLowLabel.topAnchor.constraint(equalTo: forecastsLabel.bottomAnchor, constant: 20).isActive = true
        forecastLowLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        forecastLowValueLabel.topAnchor.constraint(equalTo: forecastsLabel.bottomAnchor, constant: 20).isActive = true
        forecastLowValueLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        
        forecastDescriptionLabel.topAnchor.constraint(equalTo: forecastHighValueLabel.bottomAnchor, constant: 10).isActive = true
        forecastDescriptionLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        forecastDescriptionValueLabel.topAnchor.constraint(equalTo: forecastHighValueLabel.bottomAnchor, constant: 10).isActive = true
        forecastDescriptionValueLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        
        super.updateViewConstraints()
    }
}


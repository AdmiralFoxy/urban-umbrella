//
//  MainScreenViewModel.swift
//  urban-umbrella
//
//  Created by Stanislav on 07.08.2021.
//

import UIKit
import Combine

class WeeklyWeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var dataSource: [WeatherListViewModel] = []
    @Published var tempPoints: [(String, Double)] = []
    @Published var day: Date = .init()
    
    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()
    
    init(
        weatherFetcher: WeatherFetchable,
        scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
    ) {
        self.weatherFetcher = weatherFetcher
        $city
            .dropFirst(1)
            .debounce(for: .seconds(0), scheduler: scheduler)
            .sink(receiveValue: fetchWeather(forCity:))
            .store(in: &disposables)
        
        $day
            .map { _ in
                return self.city
            }
            .debounce(for: 0, scheduler: scheduler)
            .sink(receiveValue: setDailyWeather(forCity:))
            .store(in: &disposables)
    }
    
    
    
    func fetchWeather(forCity city: String) {
        weatherFetcher.severalDaysWeatherForecast(forCity: city)
            .map { response in
                response.list.map(WeatherListViewModel.init)
            }
            .map(Array.removeDuplicates)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] forecast in
                    guard let self = self else { return }
                    self.tempPoints = forecast.map { ($0.day, $0.main.temperature) }
                    self.dataSource = forecast
                })
            .store(in: &disposables)
    }
    
    func setDailyWeather(forCity city: String) {
        weatherFetcher.severalDaysWeatherForecast(forCity: city)
            .map { response in
                response.list.map(WeatherListViewModel.init)
            }
            .map(Array.removeDuplicates)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] forecast in
                    guard let self = self else { return }
                    let temp = forecast.filter({ $0.date.get(.day) == self.day.get(.day) }).map({ ($0.day, $0.main.temperature) })
                    
                    if temp.count <= 1 {
                        self.tempPoints = [("0", 0), temp.first!]
                    } else {
                        self.tempPoints = temp
                    }
                    
                    self.dataSource = forecast.filter { $0.date.get(.day) == self.day.get(.day) }
                })
            .store(in: &disposables)
    }
}









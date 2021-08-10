//
//  DailyWeatherRowViewModel.swift
//  urban-umbrella
//
//  Created by Stanislav on 08.08.2021.
//

import Foundation
import MapKit

struct WeatherListViewModel: Identifiable {
    private let item: WeatherList
    
    init(item: WeatherList) {
        self.item = item
    }
    
    var weatherList: WeatherList {
        return self.item
    }
    
    var id: String {
        return day + String(format: "%.1f", main.temperature) + title
    }
    
    var day: String {
        return dayFormatter.string(from: item.date ?? Date())
    }
    
    var title: String {
        guard let title = item.weather?.first?.main.rawValue else { return "" }
        return title
    }
    
    var date: Date {
        guard let date = item.date else { return Date() }
        return date
    }
    
    var main: Main {
        guard let main = item.main else { return Main(temperature: 0, feels_like_temp: 0, minTemperature: 0, maxTemperature: 0, pressure: 0, seaLevel: 0, grandLevel: 0, humidity: 0, temperatureKoef: 0) }
        return main
        
    }
    
    var weather: [Weather] {
        guard let weather = item.weather else { return [] }
        return weather
    }
    
    var clouds: Clouds {
        guard let clouds = item.clouds else { return Clouds(all: 0) }
        return clouds
    }
    
    var wind: Wind {
        guard let wind = item.wind else { return Wind(speed: 0, deg: 0, gust: 0) }
        return wind
    }
    
    var visibility: Int {
        guard let visibility = item.visibility else { return 0 }
        return visibility
    }
    
    var pop: Double {
        guard let pop = item.pop else { return 0 }
        return pop
    }
    
    var rain: Rain {
        guard let rain = item.rain else { return Rain(threeH: 0) }
        return rain
    }
    
    var snow: Snow {
        guard let snow = item.snow else { return Snow(threeH: 0) }
        return snow
    }
    
    var sys: Sys {
        guard let sys = item.sys else { return Sys(pod: "") }
        return sys
    }
}

extension WeatherListViewModel: Hashable {
    static func == (lhs: WeatherListViewModel, rhs: WeatherListViewModel) -> Bool {
        return lhs.day == rhs.day
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.day)
    }
}


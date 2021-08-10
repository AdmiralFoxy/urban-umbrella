//
//  MainModel.swift
//  urban-umbrella
//
//  Created by Stanislav on 07.08.2021.
//

import Foundation

struct Main: Codable {
    let temperature: Double
    let feels_like_temp: Double
    let minTemperature: Double
    let maxTemperature: Double
    let pressure: Int
    let seaLevel: Int
    let grandLevel: Int
    let humidity: Int
    let temperatureKoef: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feels_like_temp = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure = "pressure"
        case seaLevel = "sea_level"
        case grandLevel = "grnd_level"
        case humidity = "humidity"
        case temperatureKoef = "temp_kf"
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

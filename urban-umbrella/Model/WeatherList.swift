//
//  WeatherList.swift
//  urban-umbrella
//
//  Created by Stanislav on 08.08.2021.
//

import Foundation

struct WeatherList: Codable {
    let date: Date?
    let main: Main?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let rain: Rain?
    let snow: Snow?
    let sys: Sys?
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
        case clouds
        case wind
        case visibility = "visibility"
        case pop = "pop"
        case rain
        case snow
        case sys
    }
}

struct Clouds: Codable {
    let all: Int
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
        case gust = "gust"
    }
}

struct Rain: Codable {
    let threeH: Double
    
    enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}

struct Snow: Codable {
    let threeH: Double
    
    enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}

struct Sys: Codable {
    let pod: String
    
    enum CodingKeys: String, CodingKey {
        case pod = "pod"
    }
}





//
//  DailyWeatherModel.swift
//  urban-umbrella
//
//  Created by Stanislav on 07.08.2021.
//

import Foundation

struct DailyWeather: Decodable {
    let coordinates: Coordinates
    let main: Main
}

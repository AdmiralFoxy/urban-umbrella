//
//  WeatherError.swift
//  urban-umbrella
//
//  Created by Stanislav on 08.08.2021.
//

import Foundation

enum WeatherError: Error {
    case parsing(description: String)
    case network(description: String)
}

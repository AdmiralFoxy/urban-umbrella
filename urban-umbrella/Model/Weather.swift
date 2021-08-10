//
//  WeatherModel.swift
//  urban-umbrella
//
//  Created by Stanislav on 07.08.2021.
//

import SwiftUI
import Combine
 
struct Weather: Codable {
    let main: MainEnum
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
    }
}






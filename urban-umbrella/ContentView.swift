//
//  ContentView.swift
//  urban-umbrella
//
//  Created by Stanislav on 07.08.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WeeklyWeatherView(viewModel: WeeklyWeatherViewModel(weatherFetcher: WeatherFetcher()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

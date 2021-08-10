//
//  WeatherViewRow.swift
//  urban-umbrella
//
//  Created by Stanislav on 10.08.2021.
//

import SwiftUI
import Combine

struct WeatherViewRow: View {
    private let weatherList: WeatherListViewModel
    
    init(weatherList: WeatherListViewModel) {
        self.weatherList = weatherList
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(28)
                    .shadow(color: .black, radius: 16)
                
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Group {
                            Text(String(format: "%.1f", weatherList.main.temperature))
                            Text(String(format: "%.1f", weatherList.main.feels_like_temp))
                            Text(String(format: "%.1f", weatherList.main.maxTemperature))
                            Text(String(format: "%.1f", weatherList.main.minTemperature))
                        }
                        .font(.system(size: geometry.frame(in: .local).width * 0.0641))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .scaleEffect()
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        Group {
                            VStack(alignment: .center) {
                                Group {
                                    Text("\(weatherList.main.pressure)")
                                    Text("\(weatherList.main.seaLevel)")
                                    Text("\(weatherList.clouds.all)")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .scaleEffect()
                            }
                            
                            VStack(alignment: .center) {
                                Group {
                                    Text("\(weatherList.main.grandLevel)")
                                    Text("\(weatherList.main.humidity)")
                                    Text(String(format: "%.1f", weatherList.main.temperatureKoef))
                                }
                                
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .scaleEffect()
                            }
                        }
                        .font(.system(size: geometry.frame(in: .local).width * 0.0641))
                        .foregroundColor(.red)
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        Group {
                            VStack(alignment: .center) {
                                Group {
                                    Text("\(weatherList.weather.map { $0.weatherDescription }.first ?? "")")
                                        .scaledToFill()
                                        .padding(.leading, geometry.frame(in: .local).height * 0.0307)
                                    Text("\(weatherList.weather.map { $0.main.rawValue }.first ?? "")")
                                    Text("\(weatherList.title)")
                                    Text("\(weatherList.wind.speed)")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .scaleEffect()
                            }
                            
                            
                            VStack(alignment: .center) {
                                Group {
                                    Text("\(weatherList.wind.deg)")
                                    Text(String(format: "%.1f", weatherList.wind.gust))
                                    Text("\(weatherList.visibility)")
                                    Text("\(weatherList.sys.pod)")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .scaleEffect()
                            }
                        }
                        .font(.system(size: geometry.frame(in: .local).width * 0.0641))
                        .foregroundColor(.red)
                    }
                }
                .padding(.all, geometry.frame(in: .local).height * 0.0307)
                .padding([.vertical])
            }
        }
    }
}

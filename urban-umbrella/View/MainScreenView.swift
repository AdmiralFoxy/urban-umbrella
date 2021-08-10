//
//  MainScreenView.swift
//  urban-umbrella
//
//  Created by Stanislav on 07.08.2021.
//

import SwiftUI
import Combine

struct WeeklyWeatherView: View {
    @ObservedObject var viewModel: WeeklyWeatherViewModel
    
    @State var date: Date = Date()
    
    @State var showSearchView: Bool = false
    @State var showCalendar: Bool = false
    
    
    init(viewModel: WeeklyWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var pickerDateRange : ClosedRange<Date> {
        let calendar = Calendar.current
        let startComponents =
            DateComponents(
                year: Date().get(.year),
                month: Date().get(.month),
                day: Date().get(.day),
                hour: Date().get(.hour),
                minute: Date().get(.minute),
                second: Date().get(.second))
        
        var endComponents = DateComponents(
            year: self.date.get(.year),
            month: self.date.get(.month),
            day: self.date.get(.day),
            hour: self.date.get(.hour),
            minute: self.date.get(.minute),
            second: self.date.get(.second))
        
        if !self.viewModel.dataSource.isEmpty {
            endComponents =
                DateComponents(
                    year: self.date.get(.year),
                    month: self.date.get(.month),
                    day: Date().get(.day) + 4,
                    hour: self.date.get(.hour),
                    minute: self.date.get(.minute),
                    second: self.date.get(.second))
            
            return
                calendar.date(from:startComponents)!...calendar.date(from:endComponents)!
        }
        
        return
            calendar.date(from:startComponents)!...calendar.date(from:startComponents)!
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    ScrollView {
                        VStack {
                            searchField
                                .frame(width: geometry.frame(in: .local).width * 0.9, height: showSearchView ? 100 : 50)
                                .padding(.horizontal)
                            
                            HStack {
                                Text("Select date")
                                Image(systemName: "calendar")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .padding(.trailing, 15)
                            }
                            .offset(x: 100, y: 0)
                            .onTapGesture {
                                withAnimation {
                                    self.showCalendar.toggle()
                                }
                            }
                            
                            if !viewModel.dataSource.isEmpty {
                                VStack {
                                    ScrollViewReader { index in
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(viewModel.dataSource) { item in
                                                    WeatherViewRow(weatherList: item)
                                                        .frame(width: geometry.frame(in: .local).width * 0.45, height: geometry.frame(in: .local).height * 0.3)
                                                        .padding([.trailing, .leading], 20)
                                                        .id(item)
                                                }
                                            }
                                        }
                                        
                                        
                                        
                                        
                                        Button(action: {
                                            withAnimation {
                                                index.scrollTo(viewModel.dataSource[Int.random(in: 0...(viewModel.dataSource.count - 1))])
                                            }
                                        }, label: {
                                            Text("Scroll to random(you're lucky?)")
                                        })
                                        .padding()
                                    }
                                }
                                .padding([.vertical, .horizontal])
                            }
                        }
                        
                        if !viewModel.dataSource.isEmpty {
                            LinearGraph(
                                graphName: $viewModel.city,
                                graphIcon: .constant("list.bullet.rectangle"),
                                lineColor: .constant(.red),
                                lineGraphState: .constant(.usual),
                                points: $viewModel.tempPoints,
                                countsRange: .init(get: { viewModel.tempPoints.map { Int($0.1) }.max() ?? 0 }, set: { _ in }),
                                minCount: .init(get: { viewModel.tempPoints.map { $0.1 }.min() }, set: { _ in }),
                                maxCount: .init(get: { viewModel.tempPoints.map { $0.1 }.max() }, set: { _ in }))
                                .frame(width: geometry.frame(in: .local).width, height: geometry.frame(in: .local).height * 0.55)
                        }
                        
                    }
                }
                calendar
            }
            .navigationBarTitle("Urban Umbrella")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var calendar: some View {
        ZStack {
            GeometryReader { geometry in
                Group {
                    if showCalendar {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: geometry.frame(in: .local).width, height: geometry.frame(in: .local).height * 0.8)
                            .cornerRadius(26)
                        
                        VStack {
                            DatePicker("Prompt Text", selection: $date, in: pickerDateRange)
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .labelsHidden()
                            
                            Button(action: {
                                withAnimation {
                                    self.showCalendar.toggle()
                                    self.viewModel.day = self.date
                                }
                            }, label: {
                                Text("Done").foregroundColor(.red)
                            }).offset(x: 150, y: 0)
                        }
                        
                    }
                }.transition(.opacity.combined(with: .fade.animation(.easeOut(duration: 0.7)).combined(with: .slide.animation(.easeOut(duration: 0.4)))))
            }
        }
    }
    
    var searchField: some View {
        VStack(alignment: .center) {
            Text("Find weater for city 🔍(tap)")
                .padding(10)
                .onTapGesture {
                    withAnimation {
                        self.showSearchView.toggle()
                    }
                }
            
            if showSearchView {
                TextField("City...", text: $viewModel.city)
                    .transition(.opacity.combined(with: .fade.animation(.easeOut(duration: 0.7)).combined(with: .slide.animation(.easeOut(duration: 0.4)))))
            }
        }
    }
}




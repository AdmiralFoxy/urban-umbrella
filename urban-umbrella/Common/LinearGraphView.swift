//
//  LinearGraphView.swift
//  urban-umbrella
//
//  Created by Stanislav on 10.08.2021.
//

import SwiftUI
import Combine

struct LinearGraph: View {
    @Binding var graphName: String
    @Binding var graphIcon: String
    @Binding var lineColor: Color
    
    @Binding var lineGraphState: LineGraphMode
    @Binding var points: [(String, Double)]
    
    @Binding var countsRange: Int
    
    @Binding var minCount: Double?
    @Binding var maxCount: Double?
    
    private var setNumber: [Int] {
        var num: [Int] = []
        var index = 0
        
        self.minCount = self.points.map { $0.1 }.min()!
        self.maxCount = self.points.map { $0.1 }.max()!
        
        switch self.lineGraphState {
        case .percent:
            self.minCount = 0
            self.maxCount = 100
            let countsRange: Int = 100
            (0...4).forEach { _ in
                if index == 0 {
                    num.append(countsRange - index)
                } else {
                    num.append(countsRange - index)
                }
                index += countsRange/4
            }
        case .temperature:
            let countsRange: Int = Int(self.points.map { $0.1 }.max()!)
            
            (0...4).forEach { i in
                if index == 0 {
                    num.append(countsRange - index)
                } else if i == 4 {
                    num.append(Int(self.minCount!))
                }else {
                    num.append(countsRange - index)
                }
                index += countsRange/10
            }
        case .usual:
            let countsRange: Int = Int(self.points.map { $0.1 }.max()!)
            
            (0...4).forEach { i in
                if index == 0 {
                    num.append(countsRange - index)
                } else if i == 4 {
                    num.append(Int(self.minCount!))
                }else {
                    num.append(countsRange - index)
                }
                index += countsRange/10
            }
        }
        
        return num
    }
    
    var body: some View {
        ZStack {
            severalDays
        }
    }
    
    private var severalDays: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .frame(width: geometry.frame(in: .local).width, height: geometry.frame(in: .local).height)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                
                GeometryReader{ geometry in
                    Line(
                        data: LineData(points: self.points),
                        frame:
                            .constant(
                                CGRect(
                                    x: geometry.frame(in: .local).midX,
                                    y: geometry.frame(in: .local).maxY,
                                    width: geometry.frame(in: .local).width,
                                    height: geometry.frame(in: .local).height)),
                        touchLocation: .constant(CGPoint(x: 0, y: 0)),
                        showIndicator: .constant(true),
                        minDataValue: self.$minCount,
                        maxDataValue: self.$maxCount,
                        lineColor: $lineColor)
                }
                .frame(width: geometry.frame(in: .local).width * 0.751, height: geometry.frame(in: .local).height * 0.58)
                .offset(x: 12, y: -8)
                
                VStack {
                    HStack {
                        Group {
                            Image(systemName: graphIcon)
                            Text(graphName)
                                .font(.system(size: geometry.frame(in: .local).width * 0.0241))
                        }
                        Spacer()
                        
                        Group {
                            Text("Average")
                            
                            switch self.lineGraphState {
                            case .percent:
                                Text("\(setAverage())%")
                            case .temperature:
                                Text("\(setAverage())º")
                            case .usual:
                                Text("\(setAverage())")
                            }
                        }
                        .foregroundColor(Color(UIColor(red: 0.627, green: 0.674, blue: 0.717, alpha: 1)))
                        .font(.system(size: geometry.frame(in: .local).width * 0.0241))
                    }
                    .padding([.trailing, .leading], 10)
                    
                    HStack {
                        VStack(alignment: .center, spacing: 14.0) {
                            ForEach(0..<5) { number in
                                HStack {
                                    Group {
                                        switch self.lineGraphState {
                                        case .percent:
                                            Text("\(setNumber[number])%")
                                        case .temperature:
                                            Text("\(setNumber[number])º")
                                        case .usual:
                                            Text("\(setNumber[number])")
                                        }
                                    }
                                    .frame(width: geometry.frame(in: .local).width * 0.0301)
                                    .font(.system(size: geometry.frame(in: .local).width * 0.0241))
                                    .foregroundColor(Color(UIColor(red: 0.802, green: 0.864, blue: 0.917, alpha: 1)))
                                    VStack {
                                        Divider()
                                            .foregroundColor(Color(UIColor(red: 0.802, green: 0.864, blue: 0.917, alpha: 1)))
                                            .frame(width: geometry.frame(in: .local).width * 0.771)
                                            .frame(maxHeight: .infinity)
                                    }
                                    
                                }
                            }
                        }
                        .frame(width: geometry.frame(in: .local).width * 0.771, height: geometry.frame(in: .local).height * 0.66)
                    }
                    
                    HStack(alignment: .center, spacing: geometry.frame(in: .local).width * 0.107) {
                        ForEach(points.map { $0.0 }, id: \.self) { day in
                            Text(day)
                                .font(.system(size: geometry.frame(in: .local).width * 0.0241))
                                .foregroundColor(Color(UIColor(red: 0.802, green: 0.864, blue: 0.917, alpha: 1)))
                        }
                    }
                    .offset(x: 15, y: 0)
                }
                .padding([.trailing, .leading], 16)
            }
            .frame(width: geometry.frame(in: .local).width, height: geometry.frame(in: .local).height)
            
        }
    }
    
    
    
    private func setAverage() -> Int {
        let sumCount = self.points.map{ $0.1 }.reduce(0, +)
        let average = Double(sumCount)/Double(self.points.count)
        return Int(average)
    }
}

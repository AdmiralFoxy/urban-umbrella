//
//  LineData.swift
//  urban-umbrella
//
//  Created by Stanislav on 10.08.2021.
//

import SwiftUI

public class LineData: ObservableObject, Identifiable {
    @Published var points: [(String, Double)]
    var ID = UUID()
    
    public init(points: [(String, Int)]) {
        self.points = points.map{($0.0, Double($0.1))}
    }
    
    public init(points:[(String, Double)]) {
        self.points = points.map{($0.0, Double($0.1))}
    }
    
    public func onlyPoints() -> [Double] {
        return self.points.map{ $0.1 }
    }
}

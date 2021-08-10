//
//  AnyTransition+Extension.swift
//  urban-umbrella
//
//  Created by Stanislav on 10.08.2021.
//

import SwiftUI

extension AnyTransition {
    public static var fade: AnyTransition {
        let insertion = AnyTransition.opacity
        let removal = AnyTransition.identity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }
}

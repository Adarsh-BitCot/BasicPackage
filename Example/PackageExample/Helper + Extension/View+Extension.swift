//
//  View+Extension.swift
//  PackageExample
//
//  Created by Adarsh Sharma on 04/08/23.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self
        case false: self.hidden()
        }
    }
}

//
//  View+Extensions.swift
//  Diet Pro
//
//  Created by Lyan Alwakeel on 26/09/2022.
//

import Foundation
import SwiftUI

extension View {
    func horizontalCentre () -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
        .padding()
    }
}

//
//  ScaledButtonStyle.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 8/09/24.
//

import SwiftUI

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

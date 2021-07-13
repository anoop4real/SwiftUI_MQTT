//
//  BaseButtonStyle.swift
//  SwiftUI_MQTT
//
//  Created by Anoop M on 2021-06-29.
//

import SwiftUI

struct BaseButtonStyle: ButtonStyle {
    var foreground = Color.white
    var background = Color.blue
    
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        BaseButton(foreground: foreground, background: background, configuration: configuration)
    }
    
    struct BaseButton: View {
        var foreground: Color
        var background: Color
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .padding(EdgeInsets(top: 7.0, leading: 7.0, bottom: 7.0, trailing: 7.0))
                .frame(maxWidth: .infinity)
                .foregroundColor(isEnabled ? foreground : Color(white: 1, opacity: 179 / 255.0))
                .background(isEnabled ? background : background.opacity(0.5))
                .clipShape(Capsule())
                .opacity(configuration.isPressed ? 0.8 : 1.0)
        }
    }
}

//
//  SettingsView.swift
//  SwiftUI_MQTT
//
//  Created by Anoop M on 2021-01-20.
//

import SwiftUI

struct SettingsView: View {
    @State var brokerAddress: String = ""
    var body: some View {
        VStack {
            TextField("Enter broker Address", text: $brokerAddress)
                .padding(EdgeInsets(top: 7.0, leading: 15.0, bottom: 7.0, trailing: 7.0))
            HStack(spacing: 50) {
                Button(action: {}) {
                    Text("Connect")
                }.buttonStyle(BaseButtonStyle(foreground: .white, background: .blue))
                Button(action: {}) {
                    Text("Disconnect")
                }.buttonStyle(BaseButtonStyle(foreground: .white, background: .red))
            }
            .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

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
                .opacity(configuration.isPressed ? 0.8 : 1.0)
        }
    }
}

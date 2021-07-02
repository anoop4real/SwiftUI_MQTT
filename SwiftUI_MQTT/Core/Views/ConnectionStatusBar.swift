//
//  ConnectionStatusBar.swift
//  SwiftUI_MQTT
//
//  Created by Anoop M on 2021-06-29.
//

import SwiftUI

struct ConnectionStatusBar: View {
    var message: String
    var isConnected: Bool
    var body: some View {
        HStack {
            Text(message)
                .font(.footnote)
                .foregroundColor(.white)
        }.frame(maxWidth: .infinity)
        .background(isConnected ? Color.green : Color.red)
        
    }
}

struct ConnectionStatusBar_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionStatusBar(message: "Hello", isConnected: true)
    }
}

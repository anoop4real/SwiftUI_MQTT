//
//  SettingsView.swift
//  SwiftUI_MQTT
//
//  Created by Anoop M on 2021-01-20.
//

import SwiftUI

struct SettingsView: View {
    @State var brokerAddress: String = ""
    @EnvironmentObject private var mqttManager: MQTTManager
    var body: some View {
        VStack {
            ConnectionStatusBar(message: mqttManager.connectionStateMessage(), isConnected: mqttManager.isConnected())
            MQTTTextField(placeHolderMessage: "Enter broker Address", isDisabled: mqttManager.currentAppState.appConnectionState != .disconnected, message: $brokerAddress)
                .padding(EdgeInsets(top: 0.0, leading: 7.0, bottom: 0.0, trailing: 7.0))
            HStack(spacing: 50) {
                setUpConnectButton()
                setUpDisconnectButton()
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Configure / enable /disable connect button
    private func setUpConnectButton() -> some View  {
        return Button(action: { configureAndConnect() }) {
                Text("Connect")
            }.buttonStyle(BaseButtonStyle(foreground: .white, background: .blue))
        .disabled(mqttManager.currentAppState.appConnectionState != .disconnected || brokerAddress.isEmpty)
    }
    
    private func setUpDisconnectButton() -> some View  {
        return Button(action: { disconnect() }) {
            Text("Disconnect")
        }.buttonStyle(BaseButtonStyle(foreground: .white, background: .red))
        .disabled(mqttManager.currentAppState.appConnectionState == .disconnected)
    }
    private func configureAndConnect() {
        // Initialize the MQTT Manager
        mqttManager.initializeMQTT(host: brokerAddress, identifier: UUID().uuidString)
        // Connect
        mqttManager.connect()
    }

    private func disconnect() {
        mqttManager.disconnect()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(MQTTManager.shared())
    }
}

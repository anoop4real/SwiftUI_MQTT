//
//  ContentView.swift
//  SwiftUI_MQTT
//
//  Created by Anoop M on 2021-01-19.
//

import SwiftUI

struct ContentView: View {
    // TODO: Remove singleton
    @StateObject var mqttManager = MQTTManager.shared()
    var body: some View {
        NavigationView {
            MessageView()
        }
        .environmentObject(mqttManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MessageView: View {
    @State var topic: String = ""
    @State var message: String = ""
    @EnvironmentObject private var mqttManager: MQTTManager
    var body: some View {
        VStack {
            ConnectionStatusBar(message: mqttManager.currentAppState.appConnectionState.description, isConnected: mqttManager.currentAppState.appConnectionState.isConnected)
            HStack {
                TextField("Enter a topic to subscribe", text: $topic)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.footnote)
                    .disableAutocorrection(true)
                    .disabled(!mqttManager.currentAppState.appConnectionState.isConnected)
                
                Button(action: {subscribe(topic: topic)}) {
                    Text(titleForSubscribButtonFrom(state: mqttManager.currentAppState.appConnectionState))
                }.buttonStyle(BaseButtonStyle(foreground: .white, background: .green))
                .frame(width: 100)
                .disabled(!mqttManager.currentAppState.appConnectionState.isConnected||topic.isEmpty)
            }.padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            
            HStack {
                TextField("Enter a message", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.footnote)
                    .disableAutocorrection(true)
                    .disabled(!mqttManager.currentAppState.appConnectionState.isSubscribed)
                
                Button(action: {send(message: message)}) {
                    Text("Send")
                }.buttonStyle(BaseButtonStyle(foreground: .white, background: .green))
                .frame(width: 80)
                .disabled(!mqttManager.currentAppState.appConnectionState.isSubscribed||message.isEmpty)
            }.padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            Spacer()
        }
        .navigationTitle("Messages")
        .navigationBarItems(trailing: NavigationLink(
                                destination: SettingsView(brokerAddress: mqttManager.currentHost() ?? ""),
                                label: {
                                    Image(systemName: "gear")
                                }))
    }
    
    private func subscribe(topic: String) {
        mqttManager.subscribe(topic: topic)
    }
    
    private func usubscribe() {
        mqttManager.unSubscribeFromCurrentTopic()
    }
    
    private func send(message: String) {
        mqttManager.publish(with: message)
    }
    
    private func titleForSubscribButtonFrom(state: MQTTAppConnectionState) -> String {
        switch state {
        case .connected, .connectedUnSubscribed, .disconnected, .connecting:
            return "Subscribe"
        case .connectedSubscribed:
            return "Unsubscribe"
        }
    }
}

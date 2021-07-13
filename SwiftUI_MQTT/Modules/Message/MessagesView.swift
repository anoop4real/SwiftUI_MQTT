//
//  ContentView.swift
//  SwiftUI_MQTT
//
//  Created by Anoop M on 2021-01-19.
//

import SwiftUI

struct MessagesView: View {
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
        MessagesView()
    }
}

struct MessageView: View {
    @State var topic: String = ""
    @State var message: String = ""
    @EnvironmentObject private var mqttManager: MQTTManager
    var body: some View {
        VStack {
            ConnectionStatusBar(message: mqttManager.connectionStateMessage(), isConnected: mqttManager.isConnected())
            HStack {
                MQTTTextField(placeHolderMessage: "Enter a topic to subscribe", isDisabled: !mqttManager.isConnected() || mqttManager.isSubscribed(), message: $topic)
                Button(action: functionFor(state: mqttManager.currentAppState.appConnectionState)) {
                    Text(titleForSubscribButtonFrom(state: mqttManager.currentAppState.appConnectionState))
                        .font(.system(size: 14.0))
                }.buttonStyle(BaseButtonStyle(foreground: .white, background: .green))
                    .frame(width: 100)
                    .disabled(!mqttManager.isConnected() || topic.isEmpty)
            }.padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            
            HStack {
                MQTTTextField(placeHolderMessage: "Enter a message", isDisabled: !mqttManager.isSubscribed(), message: $message)
                Button(action: { send(message: message) }) {
                    Text("Send").font(.body)
                }.buttonStyle(BaseButtonStyle(foreground: .white, background: .green))
                    .frame(width: 80)
                    .disabled(!mqttManager.isSubscribed() || message.isEmpty)
            }.padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            MessageHistoryTextView(text: $mqttManager.currentAppState.historyText
            )
            Spacer()
        }
        .navigationTitle("Messages")
        .navigationBarItems(trailing: NavigationLink(
            destination: SettingsView(brokerAddress: mqttManager.currentHost() ?? ""),
            label: {
                Image(systemName: "gear")
            }))
    }
    
    private func subscribeUnsubscibe(topic: String) {
        mqttManager.subscribe(topic: topic)
    }
    
    private func usubscribe() {
        mqttManager.unSubscribeFromCurrentTopic()
    }
    
    private func send(message: String) {
        mqttManager.publish(with: message)
        self.message = ""
    }
    
    private func titleForSubscribButtonFrom(state: MQTTAppConnectionState) -> String {
        switch state {
        case .connected, .connectedUnSubscribed, .disconnected, .connecting:
            return "Subscribe"
        case .connectedSubscribed:
            return "Unsubscribe"
        }
    }
    
    private func functionFor(state: MQTTAppConnectionState) -> () -> Void {
        switch state {
        case .connected, .connectedUnSubscribed, .disconnected, .connecting:
            return { subscribeUnsubscibe(topic: topic) }
        case .connectedSubscribed:
            return { usubscribe() }
        }
    }
}

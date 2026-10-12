import SwiftUI

struct ContentView: View {
    @State private var head = headPosData()
    @State private var renderer = audioRenderer(source: nil)
    

    var body: some View {
        VStack(spacing: 12) {
            Text("Pitch: \(head.pitch, specifier: "%.2f")")
            Text("Roll: \(head.roll, specifier: "%.2f")")
            Text("Yaw: \(head.yaw, specifier: "%.2f")")
        }
        .font(.title2.monospacedDigit())
        .onAppear {
            renderer.start()
            head.onUpdate = { yaw, pitch, roll in
                renderer.setListenerOrientation(yaw: yaw, pitch: pitch, roll: roll)
            }
            head.startUpdates()
        }
    }
}

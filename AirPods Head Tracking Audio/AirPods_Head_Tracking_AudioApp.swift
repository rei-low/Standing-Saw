//
//  AirPods_Head_Tracking_AudioApp.swift
//  AirPods Head Tracking Audio
//
//  Created by Braxton Clark on 10/12/26.
//


import SwiftUI
import CoreAudio
import CoreMotion
import Foundation
import AVFoundation

@main
struct HeadTrackingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

@Observable

class headPosData{
   
    private let manager = CMHeadphoneMotionManager()
    var pitch = 0.0
    var roll = 0.0
    var yaw = 0.0
    @ObservationIgnored var onUpdate: ((Double, Double, Double) -> Void)?
    func startUpdates(){
        guard manager.isDeviceMotionAvailable else {
            return print("Device motion is not available")
        }

        manager.startDeviceMotionUpdates(to: .main)
        { [weak self] motion, error in
            guard let self = self, let motion = motion else { return }
    
            DispatchQueue.main.async {
                self.pitch = motion.attitude.pitch
                self.roll = motion.attitude.roll
                self.yaw = motion.attitude.yaw
                self.onUpdate?(self.yaw, self.pitch, self.roll)
            }
            
            
        }
            
    }
}

class audioRenderer{
    
    let engine = AVAudioEngine()
    let environementNode = AVAudioEnvironmentNode()
    private var source : AVAudioSourceNode?
    let player = AVAudioPlayerNode()
    
    private func setupEngine() {
        guard let source = source else { return }

        engine.attach(source)
        engine.attach(environementNode)

        let format = AVAudioFormat(standardFormatWithSampleRate: sr, channels: 1)
        engine.connect(source, to: environementNode, format: format)
        engine.connect(environementNode, to: engine.mainMixerNode, format: nil)

        environementNode.outputType = .headphones
        source.renderingAlgorithm = .HRTFHQ
        source.position = AVAudio3DPoint(x: 0, y: 0, z: -2)
    }
    func setListenerOrientation(yaw: Double, pitch: Double, roll: Double) {
        let toDeg = 180.0 / Double.pi
        environementNode.listenerAngularOrientation = AVAudio3DAngularOrientation(
            yaw: Float(-yaw * toDeg),
            pitch: Float(-pitch * toDeg),
            roll: Float(-roll * toDeg)
        )
    }
    
    func start() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playback)
        try? session.setActive(true)

        do { try engine.start() }
        catch { print("Engine failed to start:", error) }
    }
    
    private var frequency = 440.0
    private var sr = 48000.0
    private var phase = 0.0
    
    init(source: AVAudioSourceNode?, phase: Double = 0.0, frequency: Double = 440.0, sr: Double = 48000.0) {
        self.source = source
        self.frequency = frequency
        self.sr = sr
        aOsc()
        setupEngine()
    }
    
    
    
    private func aOsc() {
        guard let format = AVAudioFormat(standardFormatWithSampleRate: sr, channels: 1) else {
            return print("unavailable")
        }
        
        var phase = 0.0
        let increment = frequency / sr
        
        source = AVAudioSourceNode(format: format) { _, _, frameCount, audioBufferList in
            let buffers = UnsafeMutableAudioBufferListPointer(audioBufferList)
            
            for frame in 0..<Int(frameCount) {
                let sample = Float(2.0 * phase - 1.0) * 0.2
                phase += increment
                if phase >= 1.0 {
                    phase -= 1.0
                }
                
                for buffer in buffers {
                    buffer.mData!.assumingMemoryBound(to: Float.self)[frame] = sample
                }
            }
            
            return noErr
        }

    }
    
}

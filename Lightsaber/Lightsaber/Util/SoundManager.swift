//
//  SoundManager.swift
//  Lightsaber
//
//  Created by Alok Sagar on 13/03/22.
//

import Foundation

import AVFoundation

class SoundManager:NSObject {
    
    static let shared = SoundManager()
    var audioPlayer = AVAudioPlayer()
    var soundTimer:Timer?
    private var state:LightSaberState?
    private override init(){}
    
    
    func playSound(state:LightSaberState) {
        self.state = state
        let soundFileName = fileNameForState(saberState: state)
        var soundFileType = ".mp3" // state == .inActive ? ".m4a" : ".mp3"
        guard let audioFile = Bundle.main.path(forResource: soundFileName, ofType:soundFileType) else {
                            return
                        }
                        do {
                        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioFile))
                            if state == .active {
                                audioPlayer.numberOfLoops = -1
                            }
                            audioPlayer.prepareToPlay()
                            audioPlayer.play()
                            
                          audioPlayer.delegate = self
                            
                           

                        } catch let error {
                            print("Cannot play sound. \(error.localizedDescription)")
                        }
    }
    
    private func fileNameForState(saberState:LightSaberState) -> String{
        var soundFileName = ""
        switch saberState {
        case .turningOn:
            soundFileName = "turningOn"
        case .active:
            soundFileName = "hum"
        case .turningOff:
            soundFileName = "turningOff"
        case .inActive:
            soundFileName = ""
            break
            
        
        }
        return soundFileName
    }
    

}


extension SoundManager : AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if state == .turningOn {
            playSound(state: .active)
        }
    }
    
}

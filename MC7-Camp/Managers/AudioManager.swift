//
//  AudioManager.swift
//  MC7-Camp
//
//  Created by Paula Leite on 31/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import AVKit

class AudioManager {
    
    static let shared = AudioManager()
    
    static var numberOfLoops = -1
    
    var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    func setAudio(named name: String, withExtension extensionType: String = "mp3") {
        
        if let url = Bundle.main.url(forResource: name, withExtension: extensionType) {
            
            do {
                
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                
                audioPlayer?.numberOfLoops = AudioManager.numberOfLoops
                
            } catch {
                
                print(error)
                
            }
            
        }
        
    }
    
}

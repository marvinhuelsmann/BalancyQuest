//
//  SoundPlayer.swift
//
//
//  Created by Marvin Hülsmann on 05.12.23.
//

import AVFoundation
import Foundation


var audioPlayer: AVAudioPlayer!

func getLibraryDirectory() -> URL {
  /// find all possible documents directories for this user
  let paths = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)

  /// just send back the first one, which ought to be the only one
  return paths[0]
}

/// Play sounds
/// - Parameter sound: Sound filename
func playSound(sound: String) {
    guard let path = Bundle.main.path(forResource: sound, ofType: "mp3") else {
        print("Sound file not found")
        return
      }
      let url = URL(fileURLWithPath: path)
    
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        if !audioPlayer.isPlaying {
            audioPlayer?.play()
        } else {
            audioPlayer?.stop()
        }
    } catch {
        print(error)
    }
}

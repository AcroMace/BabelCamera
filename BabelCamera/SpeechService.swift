//
//  SpeechService.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-13.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import Foundation
import AVKit

class SpeechService {

    // http://nshipster.com/avspeechsynthesizer/
    let synthesizer = AVSpeechSynthesizer()

    func say(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)

        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1

        synthesizer.speak(utterance)
    }

}

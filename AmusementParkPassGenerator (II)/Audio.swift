//
//  Audio.swift
//  AmusementParkPassGenerator (II)
//
//  Created by Leticia Rodriguez on 6/27/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import AudioToolbox

class Audio {
    
    var accessGrantedSound: SystemSoundID = 0
    var accessDeniedSound: SystemSoundID = 0

    
func loadGameSounds() {
    let pathToSoundFile = Bundle.main.path(forResource: "AccessGranted", ofType: "wav")
    let accessGrantedURL = URL(fileURLWithPath: pathToSoundFile!)
    AudioServicesCreateSystemSoundID(accessGrantedURL as CFURL, &accessGrantedSound)
    
    let pathToCorrectAnswerSoundFile = Bundle.main.path(forResource: "AccessDenied", ofType: "wav")
    let accessDeniedURL = URL(fileURLWithPath: pathToCorrectAnswerSoundFile!)
    AudioServicesCreateSystemSoundID(accessDeniedURL as CFURL, &accessDeniedSound)
    
}

func playAccessGrantedSound() {
    AudioServicesPlaySystemSound(accessGrantedSound)
}

func playAccessDeniedSound() {
    AudioServicesPlaySystemSound(accessDeniedSound)
}
}

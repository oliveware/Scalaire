//
//  Mesure.swift
//  Knownbers (macOS)
//
//  Created by Herve Crespel on 05/06/2022.
//

import Foundation

typealias Mesure = Mesure_package
// à redéfinir dans chaqoe plateforme

struct Mesure_package {
    let width : CGFloat = 1200
    let height : CGFloat = 800
    
    // les infos du système ne sont pas dans la fenêtre
    let topading : CGFloat = 2
    
    // dimension du bouton gyroscope donnant accès au menu général
    let gyro : CGFloat = 40
    
    var colpar : CGFloat {gyro + 10}
    var wain : CGFloat {width - gyro - 10}
}

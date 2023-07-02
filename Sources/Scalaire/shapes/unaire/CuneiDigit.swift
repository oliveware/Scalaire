//
//  CuneiDigit.swift
//  Unicalc
//
//  Created by Herve Crespel on 06/08/2022.
//

import SwiftUI

@available(macOS 10.15, *)
struct CuneiDigit: View {
    var value = 12
    var size: CGFloat = 20
    var color = Color("glyph")
    var numicode : Numicode = .sumer
    
    var chiffres : String {
        let d = DoubleCunei(numicode)
        d.set(value)
        return d.chiffres
    }

    var body: some View {
        Text(chiffres)
            .font(Font(CTFontCreateUIFontForLanguage(.system, size*4,  nil)! ))
            .fontWeight(Font.Weight.bold)
            .foregroundColor(color)
    }
}



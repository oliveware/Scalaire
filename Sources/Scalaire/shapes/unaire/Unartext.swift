//
//  Unartext.swift
//  Unicalc
//
//  Created by Herve Crespel on 06/08/2022.
//

import SwiftUI

struct Unartext: View {
    var value = 3
    var size :CGFloat = 20
    var color = Color("glyph")
    var style = Unarstyle.bat
    
    func fontsize(_ glyph: String) -> CGFloat {
        glyph == "|" ? size*4 : size*4.9
    }
    func symbol(_ glyph: String) -> Text {
        Text(glyph)
            .font(Font(CTFontCreateUIFontForLanguage(.system, fontsize(glyph),  nil)! ))
            .fontWeight( glyph == "|" ? Font.Weight.bold : Font.Weight.regular)
            .foregroundColor(color)
            .baselineOffset(glyph == "|" ? 0 : size * -0.6)
    }
    
    var body: some View {
        switch value {
        case 1...4:
            HStack(spacing:size*0.4) {
                ForEach(0..<value, id: \.self) {
                    _ in
                    symbol("|")
                }
            }
        case 5:
            symbol("V")
        case 6...9:
            HStack(spacing:size*0.4) {
                Unartext(value: 5, size: size, color: color, style: style)
                Unartext(value: value-5, size: size, color: color, style: style)
            }
        case 10:
            if style == .V {
                HStack(spacing:size*0.4) {
                    symbol("V")
                    symbol("V")
                }
            } else {
                symbol("X")
            }

        default:
            Text(String(""))
           /* HStack(spacing:size*0.4) {
                symbol("X")
                Unartext(value: value%10, size: size, color: color, style: style)
            }*/
        }

    }
}

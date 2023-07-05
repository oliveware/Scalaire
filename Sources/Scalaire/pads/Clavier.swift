//
//  SwiftUIView.swift
//  
//
//  Created by Herve Crespel on 02/07/2023.
//

import SwiftUI

public struct Clavier : View {
    
    @State var scalar: Scalar
    public var numicode: Numicode
    public var power: Int
    
    var mesure = Mesure()
    var linear = false
    
    public enum Kind: String {
        case simple     = "1 chiffre"
        case digit60    = "chiffre composé d'un ou deux glyphes cunéiformes"
        case chinois    = "composition d'un groupe chinois"
        case indien     = "composition d'un groupe indien"
        case additif    = "additif antique"
    }
    
    public var kind:Kind {
        switch numicode {
        case .babylon, .sumer60:
            return .digit60
        case .hanzi, .kanji, .kor:
            return .chinois
        case .roman, .greek, .aegypt :
            return .additif
        default:
            return .simple
        }
    }
    
    public init(_ numic:Numicode, _ power:Int = 0) {
        numicode = numic
        self.power = power
    }
    
    public var body: some View {
        if numicode == .babylon || numicode == .sumer60 {
            Cuneipad(scalar:$scalar,
                     compose:Compose(DoubleCunei(numicode))
            )
        } else {
            Unipad(
                scalar:$scalar,
                graphism:numicode.graphism,
                width: mesure.width*0.3, height: linear ? 70 : mesure.height*0.3, linear:linear
            )
        }
    }
}


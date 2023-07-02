//
//  DynaDigit.swift
//  Knownbers
//
//  Created by Herve Crespel on 08/05/2022.
//

import SwiftUI

public struct Chiffre: View {
    
    var index = 7
    var classifier : String = ""
    var graphism = Graphism.none
    var config: Digiconfig
    var size: CGFloat = 20
    
   public var body: some View {
        switch graphism {
        case .bibi:
            Glyshape(index: index, set:bibibinaire)
                .frame(width: size*1.5, height: size*2.2)
        case .maya:
            ChiffreMaya(index: index, size: size*0.3)
        case .yiking:
            ChiffreHexa(index, config) //size: size*0.25)
        case .boulier:
            Text("b")
          //  Tigeboule(tige:Tige(face.abacus.type, index),width:size, height:size * 7)
        case .none:
            Chiffretext(index, classifier, size)
        }
    }
}

public struct Chiffretext: View {
    var index: Int
    var classifier : String = ""
    var size: CGFloat = 20
    
    private var fw = Font.Weight.bold
    private var cf:CTFont {
        CTFontCreateUIFontForLanguage(.system, size*2,  nil)!
    }
    var symbol: String {
      //  let range = 0..<face.pave.count
      // return range.contains(index) ? face.pave[index] : ""
        return ""
    }
    
    public init(_ value:Int, _ classifier:String, _ size:CGFloat) {
        index = value
        self.classifier = classifier
        self.size = size
    }
    
    public var body : some View {
        Text(symbol + (index == 0 ? "" : classifier))
            .font(Font(cf))
            .fontWeight(fw)
    }
}

public struct Digiconfig {
    public var size:CGFloat = 100
    public var color = Color.yellow
    public var fond = Color.black
    public var style = Hexastyle.yijing
    public var base = 64
    
    public init (_ hs:Hexastyle) {
        style = hs
    }
    
    public init(_ taille:Int, _ c:Color, _ f:Color, _ y:Hexastyle, _ b:Int = 64) {
        size = CGFloat(taille)
        color = c
        fond = f
        style = y
        base = b
    }
    
    public init (_ hc:Digiconfig) {
        size = hc.size
        color = hc.color
        fond = hc.fond
        style = .horiz
        base = hc.base
    }
}

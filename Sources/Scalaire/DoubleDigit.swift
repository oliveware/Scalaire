//
//  File.swift
//  
//
//  Created by Herve Crespel on 08/06/2022.
//

import Foundation


// composition de groupes de chiffres
@available(iOS 13.0, *)
@available(macOS 10.15, *)
public class DoubleDigit : ObservableObject {
    @Published public var glyphes : [[String]] = []
    @Published public var chiffres = ""
    @Published public var done = false
    
    public var value: Int = 0
    
    public init(_ numic: Numicode,_ base:Int = 10) {
        glyphes = Numeration(numic, base).glyphes
    }
    
    public func reset() {
        chiffres = ""
        done = false
    }
}

// composition des chiffres babyloniens à deux caractères
@available(iOS 13.0, *)
@available(macOS 10.15, *)
public class DoubleCunei: DoubleDigit {
    
    override  public init(_ numic:Numicode = .sumer, _ base:Int = 60) {
        super.init(numic, base)
    }
    
    // définition d'un chiffre sexagésimal
    public func set(_ val:Int) {
        let unit = val % 10
        add(unit)
        if val > 9 {
            add( val - unit)
        }
    }
    
    // ajoût d'une dizaine ou d'une unité

    public func add(_ v:Int) {
        if v < 10 {
            let glyphe = glyphes[1][v]
            if chiffres == "" {
                chiffres = glyphe
                value = v
            } else {
                chiffres += glyphe
                value += v
            }
        } else {
            // v vaut 10, 20, 30, 40 ou 50
            let glyphe = glyphes[0][v/10]
            if chiffres == "" {
                chiffres = glyphe
                value = v
            } else {
                chiffres = glyphe + chiffres
                value += v
            }
        }
    }


}



/*
// composition d'un couple de chiffres chinois
@available(iOS 13.0, *)
@available(iOS 13.0, *)
    @available(macOS 10.15, *)
public class DoubleChinois : DoubleDigit {
    
    override public init(_ numic: Numicode, _ base:Int = 10) {
        super.init(numic, base)
    }
    
    public func add(_ v:Int) {
        switch v {
        case 0 :
            chiffres = glyphes[2].symbols[0]
            value = 0
        case 1...9:
            let glyphe = glyphes[2].symbols[v]
            if chiffres == "" {
                chiffres = glyphe
                value = v
            } else {
                chiffres = glyphe + chiffres
                value *= v
            }
        case 10:
            set(glyphes[1].symbols[0], 10)
        case 100:
            set(glyphes[1].symbols[1], 100)
        case 1000:
            set(glyphes[1].symbols[2], 1000)
        default:
            chiffres = "unknown"
        }
    }
    
    private func set(_ glyphe:String,_ v:Int) {
        if chiffres == "" {
            chiffres = glyphe
            value = v
        } else {
            chiffres += glyphe
            value *= v
        }
    }
}

*/
    

    
 /*   public func add(_ dc:[DoubleChinois], _ p: Int) {
        var v = 0
        for i in 0..<dc.count {
            v += dc[i].value
        }
        for _ in 1..<4*p {
            v *= base
        }
        value = v
        switch numicode {
        case .kanji:
            chiffres = Kanji(v).lit()
        case .hanzi:
            chiffres = Hanzi(v).lit()
        default:
            chiffres = "unknown"
        }
        chiffres += glyphes[0].symbols[p]
    }*/


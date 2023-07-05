//
//  File.swift
//  
//
//  Created by Herve Crespel on 19/11/2021.
//

import Foundation

public var multibasemax = 72

struct Classifierset {
    var high: [String] = []
    var low: [String] = []
    var kot: [String] = []   // kind fo thing
    
    init(_ numicode:Numicode = .global) {
        switch numicode {
        case .hanzi:
            high = Chinois.symbols(.hanzi_wan)
            low = Chinois.symbols(.hanzi_10)
        case .kanji:
            high = Chinois.symbols(.kanji_man)
            low = Chinois.symbols(.kanji_10)
        case .kor:
            high = Chinois.symbols(.hangeul_man)
            low = Chinois.symbols(.hangeul_10)
        default:
            high = []
            low = []
            kot = [""]
        }
    }
}

public struct Powers {
    public var group: [String] = []  //["1000","10 000", "100 000"]
    public var digit: [String] = []   //["1","10","100"]
    
    private var power = 1
    
    public init(_ base:Int, _ groupby:Int,_ nb:Int = 3) {
        for _ in 1...groupby {
            digit.append(String(power))
            power *= base
        }
        digit.reverse()
        let groupower = power
        for i in 1...nb {
            group.append(String(power))
            // pour éviter un overflow !
            if i < nb && power < 100000000 {
                power *= groupower
            }
        }
        group.reverse()
        print(digit)
    }
}

struct Glypheset {
    var symbols:[String] = []
    
    init(_ set:[String]) {
        symbols = set
    }
    
    func symbol(_ index:Int) {
        index < symbols.count ? symbols[index] : "?"
    }
    
    subscript (_ index: Int) {
        return symbol(index)
    }
    
    func lookup(_ numic:Numicode,_ power:Int = 0) {
        switch numic {
        case .j72:  // multibase
            glyphes = [Toucheset(multibasemax).symbols]
            baserange = setbaserange(2, 72)
        case .global:
            glyphes = Decimal.symbols(.global)
            baserange = setbaserange(2, 36)
        case .aegypt:
            glyphes = Hieroglyph(power).symbols]
            baserange = setbaserange(10, 10)
            greatest = 999999
            groupby = 6
        case .alphabet:
            glyphes = [Toucheset("alphabet").symbols]
            baserange = setbaserange(2, 26)
        case .arab:
            glyphes = [Toucheset("arabe").symbols]
            baserange = setbaserange(2, 10)
            correspondingScript = .ar
        case .cunei:
            glyphes = [Toucheset("cunei10").symbols, Toucheset("cunei1").symbols]
            baserange = setbaserange(10, 10)
            groupby = 2
        case .sumer:
            glyphes = [Toucheset("sumer").symbols, Toucheset("cunei1").symbols]
            baserange = setbaserange(10, 10)
            groupby = 2
        case .sumer60:
            glyphes = [Toucheset("sumer60").symbols]
            baserange = setbaserange(2, 60)
        case .babylon:
            glyphes = [Toucheset("cunei60").symbols]
            baserange = setbaserange(2, 60)
        case .bali:
           glyphes = [Toucheset("balinese").symbols]
           baserange = setbaserange(2, 10)
        case .bengali:
           glyphes = [Toucheset("bengali").symbols]
           baserange = setbaserange(2, 10)
        case .bibi:
            glyphes = [Toucheset("bibi").symbols]
            graphism = .bibi
            baserange = setbaserange(2, 16)
            correspondingScript = .bibi
        case .birman:
           glyphes = [Toucheset("birman").symbols]
           baserange = setbaserange(2, 10)
        case .brahmi:
            glyphes = [Toucheset("brahmi").symbols]
            baserange = setbaserange(2, 10)
            groupby = 2
        case .cister:
            glyphes = [Toucheset("global").symbols]
            baserange = setbaserange(10, 10)
            groupby = 4
        case .devanagari:
            glyphes = [Toucheset("devanagari").symbols]
            baserange = setbaserange(2, 10)
            groupby = 2
        case .farsi:
           glyphes = [Toucheset("farsi").symbols]
           baserange = setbaserange(2, 10)
        case .greek:
            glyphes = [Toucheset("grec1000").symbols, Toucheset("grec100").symbols, Toucheset("grec10").symbols, Toucheset("grec1").symbols]
            baserange = setbaserange(10, 10)
            greatest = 9999
            groupby = 4
        // glyphes[0] et glyphes[1] servent à Digigroup
        case .hanzi:
            glyphes = [Toucheset("hanzi").symbols]
            baserange = setbaserange(2, 10)
            correspondingScript = .zh
            groupby = 4
            greatest = 999999999999999999
        // glyphes[0] et glyphes[1] servent à Digigroup
        case .kanji:
            glyphes = [Toucheset("kanji").symbols]
            baserange = setbaserange(2, 10)
           // ecritures = [.japa, .kanji, .japr]
            groupby = 4
            greatest = 999999999999999999
            correspondingScript = .japa
        case .khmer:
           glyphes = [Toucheset("khmer").symbols]
           baserange = setbaserange(2, 10)
            // glyphes[0] et glyphes[1] servent à Digigroup
        case .kor:
            glyphes = [Toucheset("hangeul").symbols]
            baserange = setbaserange(2, 10)
            correspondingScript = .kor
            groupby = 4
            greatest = 999999999999999999
        case .lao:
           glyphes = [Toucheset("lao").symbols]
           baserange = setbaserange(2, 10)
        case .maya:
            glyphes = [Toucheset("maya").symbols]
            graphism = .maya
            baserange = setbaserange(2, 20)
        case .roman:
            glyphes = [Toucheset("roman100000").symbols, Toucheset("roman10000").symbols, Toucheset("roman1000").symbols, Toucheset("roman100").symbols, Toucheset("roman10").symbols, Toucheset("roman1").symbols]
            baserange = setbaserange(2, 10)
            greatest = 399999
            groupby = 6
            correspondingScript = .latin
        case .shadok:
            glyphes = [Toucheset("shadok").symbols]
            baserange = setbaserange(2, 4)
        case .shadok5:
            glyphes = [Toucheset("shadok5").symbols]
            baserange = setbaserange(2, 5)
        case .telugu:
           glyphes = [Toucheset("telugu").symbols]
           baserange = setbaserange(2, 10)
        case .thai:
           glyphes = [Toucheset("thai").symbols]
           baserange = setbaserange(2, 10)
        case .yiking:
            glyphes = [Toucheset("yiking").symbols]
            graphism = .yiking
            baserange = setbaserange(2, 64)
        }
    }
    
}
    
   

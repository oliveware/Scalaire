//
//  File.swift
//  
//
//  Created by Herve Crespel on 23/11/2021.
//

import Foundation
import SwiftUI

// jeux de chiffres compatibles avec une langue
public var ecrinums : [Ecriture:[Numicode]] = [
    .af:[.global],
    .als:[.global],
    .amh:[.global],
    .ar:[.arab, .global],
    .hy:[.global],
    .bok:[.global],
    .br:[.global],
    .bro:[.global],
    .bsq:[.global],
    .bg:[.global],
    .chol:[.global],
    .dan:[.global],
    .de:[.global],
    .en:[.global],
    .esto:[.global],
    .far:[.farsi],
    .fr:[.global],
    .hnd:[.brahmi, .devanagari],
    .irg:[.global],
    .isl:[.global],
    .it:[.global],
    .japa:[.kanji],
    .kor:[.hanzi],
    .latin:[.roman],
    .letton:[.global],
    .litua:[.global],
    .mal:[.global],
    .mapu:[.maya],
    .nl:[.global],
    .pin:[.hanzi],
    .pic:[.global],
    .pol:[.global],
    .pt:[.global],
    .rhg:[.global],
    .rus:[.global],
    .scg:[.global],
    .sp:[.global],
    .serb:[.global],
    .sue:[.global],
    .tmz:[.global,.arab],
    .turc:[.global],
    .twn:[.hanzi],
    .viet:[.global],
    .wag:[.global]
]

/*public var numerations : [Numicode:Numeration] = [
    .glob:Numeration(.glob, 2, 10),
    .arab:Numeration(.arab, 2, 10),
    .aegypt:Numeration(.aegypt, 10, 10),
    .greek:Numeration(.greek, 2, 10),
    .roman:Numeration(.roman, 2, 10),
    .maya:Numeration(.maya, 2, 20),
    .brahmi:Numeration(.brahmi, 2, 10),
    .devanagari:Numeration(.devanagari, 2, 10),
    .shadok:Numeration(.shadok, 2, 10),
    .babylon:Numeration(.babylon, 60, 60),
    .alphabet:Numeration(.alphabet, 2, 36),
    .yiking:Numeration(.yiking, 64, 64),
    .hanzi:Numeration(.hanzi, 2, 10),
    .kanji:Numeration(.kanji, 2, 10),
    .farsi:Numeration(.farsi, 2, 10),
    .bali:Numeration(.bali, 2, 10),
]*/

public enum Numictype: String {
    case all = "all numic"
    case dead = "dead numic"
    case artificial = "artificial numic"
    case live = "live numic"
}

// Jeux de chiffres
public struct Numicodeset {
    public let name: LocalizedStringKey
    public let set:[Numicode]

    public init(_ type:Numictype) {
        name = LocalizedStringKey(type.rawValue)
        switch type {
        case .all:
            set = [.global, .aegypt, .arab, .babylon, .bali, .bibi, .brahmi, .cister, .devanagari, .farsi, .greek, .hanzi, .kanji, .khmer, .kor, .lao, .maya, .roman, .shadok,.shadok5, .sumer60, .telugu, .thai, .yiking, .alphabet,.j72 ]
        case .dead:
            set = [.sumer60, .babylon, .aegypt, .greek, .roman, .maya,.cister]
        case .artificial:
            set = [.bibi, .shadok, .shadok5, .yiking, .alphabet, .j72 ]
        case .live:
            set = [.global, .arab, .bali, .brahmi, .devanagari, .farsi, .hanzi, .kanji, .khmer, .kor, .lao, .telugu, .thai]
        }
    }
    
    init(_ n:LocalizedStringKey, _ s:[Numicode]) {
        name = n
        set = s
    }
        
    public func othercodes(_ exclude:Numicode) -> Numicodeset{
        var others :[Numicode] = []
        for i in 0..<set.count {
            let item = set[i]
            if exclude != item {
                others.append(item)
            }
        }
        return Numicodeset(name, others)
    }
}

public enum Numicode: LocalizedStringKey {
    case j72        = "numic72"
    case global     = "globalnumic"
    
    case aegypt     = "aegypt"
    case alphabet   = "alphabet"
    case arab       = "arab"
    // case aztek      = "aztèques"
    case babylon    = "babylon"
    case bibi       = "bibibi"
    case cunei      = "cuneibaby"
    case bali       = "bali"
    case bengali    = "bengali"
    case birman     = "birman"
    case brahmi     = "brahmi"
    case cister     = "cister"
    case devanagari = "devanagarî"
    case farsi      = "farsi"
    case greek      = "agreek"
    case hanzi      = "china"
    case kanji      = "japan"
    case khmer      = "khmer"
    case kor        = "korean"
    case lao        = "lao"
    case maya       = "maya"
   // case quenya     = "quenya"
    case roman      = "roman"
    case shadok     = "shadok"
    case shadok5    = "shadok5"
    case sumer60      = "sumerian"
    case sumer     = "cuneisumer"
    case telugu     = "telugu"
    case thai       = "thai"
    case yiking     = "yiking"
   
}

public enum Graphism : String {
    case bibi       = "bibi-binaire"
    case maya       = "maya"
    case yiking     = "yiking"
    case none       = "none"
    case boulier    = "boulier"
}

public enum Clavier: String {

    case simple     = "1 chiffre"
    case digit60    = "chiffre composé d'un ou deux glyphes cunéiformes "
    case chinois    = "composition d'un groupe chinois"
    case indien     = "composition d'un groupe indien"
    case additif    = "additif antique"
}

public struct Numeration {

    public var glyphes: [[String]] = []     // caractères unicode utilisés comme chiffres
    public var classifiers = Classifierset() // caractères unicode des classifieurs
    public var numicode = Numicode.global
    public var graphism = Graphism.none
    public var isgraphic: Bool {graphism != .none}   // true si les chiffres sont des graphismes composés par des programmes SwiftUI
    public var base = 10
    public var nativebase = 10
    public var baserange : ClosedRange<Int> = 2...10

    // le plus grand nombre qui bloque la saisie (vaut 0 lorsqu'il n'y pas de limite)
    public var greatest = 99999
    
    // écriture correspondant au numicode
    // bro ne correspond à une aucun numicode
    public var correspondingScript = Ecriture.bro
    
    public var isglobal10: Bool {
        numicode == .global && base == 10
    }
    
    public var clavier:Clavier {
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
    
    public func isnot(_ numer:Numeration) -> Bool {
        return numicode != numer.numicode || base != numer.base
    }
    
    public func sature(_ value:Int)->Bool {
        if greatest == 0 {
            return false
        } else {
            return value >= greatest - 10
        }
    }
    
    // groupement des chiffres
    public var groupby = 3
    
    public init(_ numic:Numicode = .global, _ b:Int = 10){
        set(numic)
        set(b)
    }

    mutating private func set(_ numic:Numicode) {
        numicode = numic
        classifiers = Classifierset(numic)
        setnativebase()
        switch numic {
        case .j72:  // multibase
            glyphes = [Toucheset(multibasemax).symbols]
            baserange = setbaserange(2, 72)
        case .global:
            glyphes = Decimal.symbols(.global)
            baserange = setbaserange(2, 36)
        case .aegypt:
            glyphes = [Toucheset("rond").symbols, Toucheset("index").symbols, Toucheset("lotus").symbols, Toucheset("corde").symbols, Toucheset("anse").symbols, Toucheset("baton").symbols]
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
    // à corriger et compléter compléter
    public func pave(_ index:Int = 0, _ clavier: Clavier = .simple)->[String] {
        // 0 -> pavé des unités
        let nbp = glyphes.count
        if clavier == .simple {
            return glyphes[nbp-1]
        } else {
            if clavier == .digit60 {
                return glyphes[0]
            } else {
                let p = index % nbp
                return glyphes[nbp-1 - p]
            }
        }

    }
    
    public func glyphe(_ touchvalue:Int, _ touchpower:Int)-> String {
        
        let pave = touches(touchpower)
        if touchvalue < pave.count {
            return pave[touchvalue]
        } else {
            return "?"  // Toucheset incomplet
        }
    }
    public func touches(_ touchpower:Int)->[String] {
        let nbpave = glyphes.count
        if nbpave == 1 {
            return glyphes[0]
        } else {

            if touchpower == 0 {
                return glyphes[nbpave-1]
            } else {
                let set = touchpower % nbpave
                return glyphes[nbpave-set-1]
            }
        }
    }

    
 /*   public var antikzero:[Int] {
        var touches:[Int] = []
        for _ in 0..<glyphes.count {
            touches.append(0)
        }
        return touches
    }*/
    
    public func passlock(_ touchcount:Int)->Bool{
        return touchcount >= glyphes.count
    }
   
    
    func setbaserange(_ a:Int,_ b:Int)->ClosedRange<Int> {
        let unit = glyphes.count-1
        var nbc = glyphes[unit].count
        if nbc > multibasemax { nbc = multibasemax }
        let min = a <= b ? a : b
        let max = a <= b ? b : a
        var range : ClosedRange<Int>
        if min <= nbc && nbc <= max {
            range = min...nbc
        } else {
            if nbc < min {
                range = 2...nbc
            } else {
                range = min...max
            }
        }
        return range
    }
    
    func setnativebase() {
        switch numicode {
        case .shadok:
            nativebase = 4
        case .shadok5:
            nativebase = 5
        case .bibi:
            nativebase = 16
        case .maya:
            nativebase = 20
        case .yiking:
            nativebase = 64
        case .babylon, .sumer60:
            nativebase = 60
        case .alphabet:
            nativebase = 26
        case .j72:
            nativebase = 72
        default:
            nativebase = 10
        }
    }
    
    public func setbasetonative()-> Int {
        base = nativebase
        return base
    }
    
    func set(_ asked:Int) {
        if baserange.contains(asked) {
            base = asked
        } else {
            let min = baserange.lowerBound
            if asked < min {
                base = min
            } else {
                let max = baserange.upperBound
                if asked > max {
                    base = max
                } else {
                    base = asked
                }
            }
        }
    }
    
    public func change(_ incordec:Bool) {
        var b: Int
        if incordec {
            if base == baserange.upperBound {
                b = baserange.lowerBound
            } else {
                b = base + 1
            }
        } else {
            if base == baserange.lowerBound {
                b = baserange.upperBound
            } else {
                b = base - 1
            }
        }
        change(numicode, b)
    }
    
    public func setbase(_ newbase: Int) {
        if baserange.contains(newbase) {
            change(numicode, newbase)
        }
    }
    
    public func change(_ choice:Numicode,_ b:Int, _ locked:Bool = false){
        graphism = .none
        groupby = 3
        set(choice)
        // base est encore l'ancienne base
        if locked {
           if !baserange.contains(base) {
                set(b)
           }
        } else {
           set(b)
        }
    }
    
    func complangs()->[Ecriture]{
        var complangs:[Ecriture] = []
        for e in 0..<ecritures.count {
            let lgs = ecrinums[ecritures[e]]
            if lgs != nil {
                for l in 0..<lgs!.count {
                    if lgs![l] == numicode {
                        complangs.append(ecritures[e])
                    }
                }
            }
        }
        return complangs
    }
}


//
//  SuiteChiffres.swift
//  
//
//  Created by Herve Crespel on 19/11/2021.
//

import Foundation

// Une suite de chiffres représente un entier naturel dans une base et une numération données

@available(iOS 13.0, *)
    @available(macOS 10.15, *)
public class SuiteChiffres {
    // les touches sont dans l'ordre des puissances de la base
    // l'indice 0 a la plus grande puissance
    internal var touches : [Int] = []
    
    internal var numicode = Numicode.global
    internal var base = 10
    //  true si saisie avec un clavier antique multipavés
    private var antik = false
    
    internal var numeration: Numeration {
        Numeration(numicode, base)
    }
    
    deinit {
        touches = []
    }
    
    public init(_ numer: Numeration) {
        set(numer)
    }
    
    public init(_ groupes: [[Int]], _ numer: Numeration) {
        set(numer)
        set(groupes)
    }
    public init(_ scalars: [[[[Int]]]], _ selection:[Int], _ numer: Numeration) {
        set(numer)
        if selection.count > 1 {
            let scalar = scalars[selection[0]]
            let suitindex = selection[1] == 0 ? 0 : 1
            let suite = scalar[suitindex]
           // var groupes : [[Int]]
            if selection.count == 2 {
               // groupes = suite
                set(suite)
            } else {
                let groupindex = selection[2]
                if suite.count > groupindex {
                   // groupes = [suite[groupindex]]
                    set([suite[groupindex]])
                }
            }
           // set(groupes)
        }
    }
    
    public init(_ entier:Int, _ numer: Numeration){
        set(numer)
        refresh(entier)
    }
    
    private func set(_ numer:Numeration) {
        numicode = numer.numicode
        base = numer.base
    }
    private func set(_ groupes: [[Int]]) {
        for g in 0..<groupes.count {
            let groupe = groupes[g]
            for c in 0..<groupe.count {
                touches.append(groupe[c])
            }
        }
    }
    
    private func refresh(_ entier:Int) {
        touches = []
        // conversion en chiffres dans la base du nombre
        var nombre = entier
        var reste = 0
        // le reste définit les touches dans l'ordre unité, dizaine, centaine, etc.
        while nombre >= base {
            reste = nombre % base
            add(reste)
            nombre = (nombre-reste)/base
        }
        if nombre > 0  { add( nombre) }
        // rétablir l'ordre des puissances décroissantes
        touches.reverse()
    }
    
    public func reset() {
        touches = []
    }
    
    public var isNaN: Bool { touches == [] }
    
    public var isnul: Bool {
        switch touches.count {
        case 0:
            return false
        case 1:
            if touches[0] == 0 {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }
    
    public var sature:Bool {
        let greatest = numeration.greatest
        if greatest == 0 {
            return false
        } else {
            return value >= greatest - 10
        }
    }
    
    public func convert(_ new: Numeration){
        let oldvalue = value
        if numeration.isnot(new) {
            numicode = new.numicode
            base = new.base
            refresh(oldvalue)
        }
    }
    
    public func add(_ input:Int, _ additif:Bool = false, _ power:Int = 0) {
        if additif {
            refresh(value + basepower(power) * input)
        } else {
            touches.append(input)
        }
    }
    
    public var passlock:  Bool { numeration.passlock(count) }
    
    public func formattedString(_ lor:Bool = true) -> String {
        var chiffres = ""
        let groupes = formatted(lor)
        let nbg = groupes.count
        if nbg > 0 {
            chiffres = groupes[0]
            if nbg > 1 {
                for i in 1..<nbg {
                    chiffres += " " + groupes[i]
                }
            }
        }
        return chiffres
    }
    
    // formatte en groupes de chiffres la valeur entière(left) ou décimale(!left), selon la numération
    public func formatted(_ lor: Bool)-> [String] {
            let nbdigits = touches.count
            var index = 0
            let groupby = numeration.groupby
            if groupby == 0 {
                return [extract(&index, nbdigits)]
            } else {
                var groups : [String] = []
                let isolate = nbdigits % groupby
                
                if lor {   // partie entière
                    if isolate > 0 { groups.append(extract(&index, isolate)) }
                }
                for _ in 0..<(nbdigits-isolate) / groupby {
                    groups.append(extract(&index, groupby))

                }
                if !lor {  // partie décimale
                    if isolate > 0 { groups.append(extract(&index, isolate)) }
                }
                return groups
            }
    }
    
    private func extract(_ index: inout Int,_ nbdigits:Int)->String {
        var group = ""
        for _ in 0..<nbdigits {
            group += glyphe(index)
            index += 1
        }
        return group
    }
    
    // tableau des touches formatté en groupes de touches, selon la numération
    public func groupes(_ lor: Bool)-> [[Int]] {
        let nbdigits = touches.count
        var index = 0
        let groupby = numeration.groupby
        if groupby == 0 {
            return [extract(&index, nbdigits)]
        } else {
            var groups : [[Int]] = []
            let isolate = nbdigits % groupby
            
            if lor {   // entier
                if isolate > 0 { groups.append(extract(&index, isolate)) }
            }
            for _ in 0..<(nbdigits-isolate) / groupby {
                groups.append(extract(&index, groupby))

            }
            if !lor {  // partie décimale
                if isolate > 0 { groups.append(extract(&index, isolate)) }
            }
            return groups
        }
    }
    
    private func extract(_ index: inout Int,_ nbdigits:Int)->[Int] {
        var group :[Int] = []
        for _ in 0..<nbdigits {
            group.append(touches[index])
            index += 1
        }
        return group
    }
    
    internal func glyphe(_ n:Int)-> String {
        let nbp = numeration.glyphes.count
        let power = antik ? nbp-1-n : count-1-n
        return numeration.glyphe(touches[n], power)
    }
    
    // groupe les chiffres de droite à gauche
    public var asleft: [String] {
        switch numicode {
        case .kanji:
            return [Kanji(value).lit()]
        case .hanzi:
            return [Hanzi(value).lit()]
        case .kor:
            return [Hangeul(value).lit()]
        default :
            return formatted(true)
        }
    }
    // groupe les chiffres de gauche à droite
    public var asright: [String] {
        formatted(false)
    }
    
    public var entiere : Double {
        Double(value)
    }
    
    public var decimales : Double {
        return Double(value) / Double(puissance)
    }
    
    var count: Int {
        return touches.count
    }
    
    var puissance:Int { basepower(count) }
    
    // valeur en base 10
    public var value: Int {
        if count == 0 {
            return 0
        } else {
            var val = 0
            //  les touches sont dans l'ordre des puissances descendantes
            for i in 0..<count {
                val += touches[i] * basepower(count-i-1)
            }
         /*   // complétion des touches de faible poids absentes
            if antik {
                let nbp = numeration.glyphes.count
                val = val * basepower(nbp - (count % nbp))
            }*/
            return val
        }
    }
    
    func basepower(_ p:Int) -> Int {
       
        if p == 0 {
            return 1
        } else {
            var r = 1
            for _ in 1...p {
                // arithmetic overflow à gérer
                r = r * base
            }
            return r
        }
    }
}



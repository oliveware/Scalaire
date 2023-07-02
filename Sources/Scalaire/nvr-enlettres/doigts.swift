//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Doigts {

var doigts = ["a", "e", "i", "o", "u", "y"]
var mains = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p"]

var powfix = ["", "q", "r", "s", "t", "v", "w", "x", "z", "rk", "rt", "rm", "rn", "rp", "sk", "st", "sm", "sn", "sp"]

var units : [String] = ["zif"]
var powords : [[String]] = []
var liaison = " "

var decival = 0     // valeur entière en base 10
var base = 20
var powers : [Int] = []

public init(_ value : Int, _ base:Int = 20) {
    decival = value
    self.base = base
    
    makepowers()
    makeunits()
    
    powords = []
    for p in 0..<powfix.count {
        var words : [String] = []
        for i in 0..<units.count {
            words.append(units[i] + powfix[p])
        }
        powords.append(words)
    }
   // print ("powords : ", powords)
}

func makeunits() {
    let nd = doigts.count
    var nbh = 1
    if base > nd {
        nbh = (base - base % nd) / nd
        if base % nd > 0 { nbh += 1 }
    }
    for h in 1...nbh {
        var i = 0
        while i < nd && (h-1)*nd + i < base {
            units.append(mains[h-1] + doigts[i])
            i += 1
        }
    }
}

func makepowers() {
    let np = powfix.count
    var power = 1
    powers = [power]
    for _ in 1...np {
        if (decival - decival%base)/base > power {
            power = power * base
            powers.append(power)
        }
    }
}

public func lit()->String {
    if decival == 0 {
        return units[0]
    } else {

        var digits : [Int] = []
        
        var reduce = decival
        while reduce > 0 {
            let digit = reduce%base
            digits.append(digit)
            reduce = (reduce - digit)/base
        }
        
        digits = digits.reversed()

        return lit(digits)
    }
}

public func lit(_ native:[Int])->String {
    let digits = native == [] ? [0] : native

    var words = ""
    let nw = digits.count - 1
    
    for i in 0...nw {
        if digits[i] > 0 {
            words += powords[nw-i][digits[i]]
            if i < nw { words += liaison }
        }
    }
   
   // print(digits, words)
    return words
}


}

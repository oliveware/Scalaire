//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

// expression littérale de la numération bibi-binaire en base 16
// consiste en une énumération des chiffres
public class Bibi: Litteral {
    
    public override init(_ value: Int) {
        super.init(value)
        // non utilisé dans l'algorithme
        powers = [256, 4096, 16777216, 68719476736, 281474976710656]
        
        masculin = ["ho", "ha", "he", "hi", "bo", "ba", "be", "bi", "ko", "ka", "ke", "ki", "do", "da", "de", "di"]
        feminin = masculin
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let unite = n%16
        let dizaine = ((n-unite)/16)%16
        switch dizaine {
        case 0:
            return masculin[unite]
        default:
            return masculin[dizaine-1] + masculin[unite]
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let power = powers[0]
        let cent = ((n-n%power)/power)%16
     
        switch cent {
        case 0:
            return dizunit(n)
        default:
            return masculin[cent] + dizunit(n)
        }
    }
    public override func mil(_ n:Int)-> String {
        let power = powers[1]
        let mil = ((n-n%power)/power)%power
        let cdu = n%power == 0 ? "" : centdizunit(n%power)
        
        switch mil {
        case 0:
            return centdizunit(n%power)
        default:
            return construct(mil) + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let power = powers[2]
        let milmil = ((n-n%power)/power)%power
        
        switch milmil {
        case 0:
            return mil(n%power)
        default:
            return construct(milmil) + mil(n%power)
        }
    }
    public override func milliard(_ n:Int)-> String {
        let power = powers[3]
        let milmilmil = ((n-n%power)/power)%power
        
        switch milmilmil {
         case 0:
             return million(n%power)
         default:
            return construct(milmilmil) + million(n%power)
        }
    }
    public override func billion(_ n:Int)-> String {
        let power = powers[4]
        let milmilliard = ((n-n%power)/power)%power
        
        switch milmilliard {
         case 0:
             return milliard(n%power)
         default:
            return construct(milmilliard) + milliard(n%power)
        }
    }
}

// expression littérale d'une numération en base 16
public class Brooding: Litteral{
    
    public override init(_ value: Int) {
        super.init(value)
        // non utilisé dans l'algorithme
        powers = [256, 4096, 16777216, 68719476736, 281474976710656]
        
        masculin = ["zromed", "wen", "raich", "schlaum", "draugen", "klaut", "khlobed", "sken", "hoon", "saed", "thlad", "feyeed", "mawg", "braled", "graizeeg", "slathlaan"]
        feminin = masculin
            
        dizaines = ["fluhn", "raichfluhn", "schlaumfluhn", "draugenfluhn", "klautfluhn", "khlobedfluhn", "skenfluhn", "hoonfluhn", "saedfluhn", "thladfluhn","feyeedfluhn","mawgfluhn","braledfluhn","graizeegfluhn", "slathlaanfluhn"]
            
        singrand = ["tegen","stooraen","sezmeg","sizhuitera"]  // sezmeg et sizhuitera sont inventés pour compléter
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let unite = n%16
        let dizaine = ((n-unite)/16)%16
        switch dizaine {
        case 0:
            return masculin[unite]
        default:
            let liaison = " "
            return dizaines[dizaine-1] + liaison + masculin[unite]
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%256)/256)%16
     
        switch cent {
        case 0:
            return dizunit(n)
        case 1:
            return "tegen " + dizunit(n)
        default:
            return masculin[cent] + "tegen " + dizunit(n)
        }
    }
    
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%4096)/4096)%4096
        let cdu = n%4096 == 0 ? "" : centdizunit(n%4096)
        
        switch mil {
        case 0:
            return centdizunit(n%4096)
        case 1:
            return "stooraen " + cdu
        default:
            return construct(mil) + singrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%16777216)/16777216)%16777216
        
        switch milmil {
        case 0:
            return mil(n%16777216)
        case 1:
            return singrand[2] + " " + mil(n%16777216)
        default:
            return construct(milmil) + singrand[2] + " " + mil(n%16777216)
        }
    }
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%68719476736)/68719476736)%68719476736
        
        switch milmilmil {
         case 0:
             return million(n%68719476736)
         case 1:
             return singrand[3] + " " + million(n%68719476736)
         default:
             return construct(milmilmil) + singrand[3] + " " + million(n%68719476736)
        }
    }
}

// expression littérale multibase
public class Universal {

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

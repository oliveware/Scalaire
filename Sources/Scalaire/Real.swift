//
//  Real.swift
//  
//
//  Created by Herve Crespel on 14/02/2022.
//

import Foundation

// représentation Swift de la valeur d'un nombre scalaire

//  La valeur d'un nombre réel est représentée avec Int et Double
// ainsi, les calculs restent en nombre entier lorsque c'est possible
// tous les calculs se font en base 10

public struct Real {
    // représentation swift d'un nombre entier naturel ou relatif
    internal var relatif: Int = 0
    // représentation swift d'un nombre décimal
    // relatif au numérateur et dénominateur
    internal var denominator: Int = 1
    // ou valeur décimale dans un double
    internal var decimal: Double = 0.0

    public var isNaN = true
    public var set = ScalarSet.R

    public var isinfinite = false
    
    public init(_ n:Int) {
        relatif = n
        decimal = Double(n)
        isNaN = false
        set = ( n < 0 ? .Z : .N )
    }
    
    public init(_ n:Double) {
        decimal = n
        isNaN = false
        relatif = Int(n)
        set = Double(Int(n)) == n ? ( n < 0 ? .Z : .N ) : .R
    }
    
    // conversion d'un rationnel en réel
    public init(_ fraction:Rational){
        if fraction.isNaN {
            isNaN = true
        } else {
            set2int(fraction.num,fraction.den)
        }
    }
    
    public init(_ num:Int,_ den:Int){
        set2int(num,den)
    }
    
   mutating private func set2int(_ num:Int,_ den:Int) {
        if den == 0 {
            isinfinite = true
        } else {
            if num % den == 0 {
                relatif = num / den
                denominator = 1
                set = num*den < 0 ? .Z : .N
            } else {
                relatif = num
                denominator = den
                set = .Q
            }
            decimal = Double(num) / Double(den)
            isNaN = false
        }
    }
    
    public init(){
        isNaN = true
    }
    
    public var asMashix: Mashix {
        return Mashix(r:self)
    }
    
    public var clone:Real {
        switch set {
        case .N,.Z:
            return Real(relatif)
        case .Q:
            return Real(relatif, denominator)
        default:
            return Real(decimal)
        }
    }
    
    public var isnul : Bool { decimal == 0.0 && relatif == 0 && !isNaN}
    public var isrelative : Bool { (set == .N) || (set == .Z) }
    
    public var negatif:Bool { relatif * denominator < 0 || decimal < 0 }
    
    // conversion d'un réel en rationnel
    public var rational:Rational {
       Rational(relatif, denominator)
    }
    
    // pour initialiser DigitalRepresentation par set
    public var g10chars : [Character] {
        var stringval = ""
        if isrelative {
            stringval = relatif < 0 ? String(-relatif) : String(relatif)
        } else {
            stringval = decimal < 0 ? String(-decimal) : String(decimal)
        }
        return Array(stringval)
    }
    
    // valeur absolue de la partie entière
    public var valint : Int {
        if isrelative {
            return relatif < 0 ? -relatif : relatif
        } else {
            return decimal < 0 ? -Int(decimal) : Int(decimal)
        }
    }
    
    // entier positif
    public var valdec : Int {
        if isrelative {
            return 0
        } else {
            let absoludec = decimal < 0 ? -decimal : decimal
            var entiere = String(absoludec)
            var dotpassed = false
            var decimales = ""
            while entiere.count > 0 {
                let digit = String(entiere[entiere.startIndex])
                if  digit == "." {
                    dotpassed = true
                } else {
                    if dotpassed {
                        decimales += digit
                    }
                }
                entiere.remove(at: entiere.startIndex)
            }
            return Int(decimales)!
        }
    }
    
    public var oppose: Real {
        if set == .N {
            return Real()   // NaN
        } else {
            if set == .Z {
                return Real(-relatif)
            } else {
                if set == .Q {
                    return Real(-relatif, denominator)
                } else {
                    return Real(-decimal)
                }
            }
        }
    }
    
    public var inverse:Real {
        if set == .N {
            return Real()   // NaN
        } else {
            if set == .Z {
                return Real(1, relatif)
            } else {
                if set == .Q {
                   return Real(denominator, relatif)
                } else {
                    return Real(1/decimal)
                }
            }
        }
    }
    
    // valeur absolue
    public var absolute:Real {
        if negatif {
            return oppose
        } else {
            return self
        }
    }
    public static func + (_ a:Real, _ b:Real) -> Real {
        return a.add(b)
    }
    public static func - (_ a:Real, _ b:Real) -> Real {
        return a.substract(b)
    }
    public static func * (_ a:Real, _ b:Real) -> Real {
        return a.multiply(b)
    }
    public static func / (_ a:Real, _ b:Real) -> Real {
        return a.divide(b)
    }
    
    public func add(_ b:Real)-> Real{
        if set == .N || b.set == .Z {
            if b.set == .N || b.set == .Z {
                return Real(relatif + b.relatif)
            } else {
                if b.set == .Q {
                    return Real(self.rational.add( b.rational))
                } else {
                    return Real(Double(relatif) + b.decimal)
                }
            }
        } else {
            if b.set == .Q {
                if set == .Q {
                    return Real(self.rational.add(b.rational))
                } else {
                    return Real(decimal + b.decimal)
                }
            } else {
                return Real(decimal + b.decimal)
            }
        }
    }
    
    public func substract(_ b:Real)-> Real{
        if isrelative {
            if b.isrelative {
                return Real(relatif - b.relatif)
            } else {
                return Real(Double(relatif) - b.decimal)
            }
        } else {
            if b.isrelative {
                return Real(decimal - Double(b.relatif))
            } else {
                return Real(decimal - b.decimal)
            }
        }
    }
    
    public func multiply(_ b:Real)-> Real{
        if isrelative {
            if b.isrelative {
                return Real(relatif * b.relatif)
            } else {
                return Real(Double(relatif) * b.decimal)
            }
        } else {
            if b.isrelative {
                return Real(decimal * Double(b.relatif))
            } else {
                return Real(decimal * b.decimal)
            }
        }
    }
    
    public func divide(_ b:Real)-> Real{
        if isrelative {
            if b.isrelative {
                return Real(Double(relatif) / Double(b.relatif))
            } else {
                return Real(Double(relatif) / b.decimal)
            }
        } else {
            if b.isrelative {
                return Real(decimal / Double(b.relatif))
            } else {
                return Real(decimal / b.decimal)
            }
        }
    }
    
    public func puissance(_ power:Real)->Real {
        if power.isnul {
            return Real(1)
        } else {
            if power.isrelative {
                let negatif = power.relatif < 0
                let p = negatif ? -power.relatif : power.relatif
                var result = Real(1)
                for _ in 1..<p {
                    result = multiply(result)
                }
                if power.negatif {
                    return result.inverse
                } else {
                    return result
                }
            } else {
                if power.decimal == 0.5 {
                    return Real(sqrt(decimal))
                } else {
                    return Real(exp(power.decimal * log(decimal)))
                }
            }
        }
    }
    
    public var expon:Real {
        return Real(exp(decimal))
    }
    
    public var sinus:Real {
        return Real(sin(decimal))
    }
    public var cosinus:Real {
        return Real(cos(decimal))
    }
    public var tangente:Real {
        return Real(tan(decimal))
    }
    
    public var log10:Real {
        return Real(log(decimal) / log(10))
    }
    public var ln:Real {
        return Real(log(decimal))
    }
    
}

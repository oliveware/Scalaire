//
//  File.swift
//  
//
//  Created by Herve Crespel on 02/07/2023.
//

import Foundation


public struct Scalar {
    
    internal var minus = false
    
    // pour un rationnel, chiffres du numérateur en valeur absolue
    // pour un non rationnel, chiffres de la partie entière en valeur absolue
    internal var nument : SuiteChiffres
    
    // pour un rationnel, chiffres du dénominateur en valeur absolue
    // pour un non rationnel, chiffres de la partie décimale en valeur absolue
    // vide pour un entier
    internal var dendec : SuiteChiffres
    
    internal var firstselected = true
    internal var scalarset = ScalarSet.N
    internal var hasdot = false
    
    public var isrelative: Bool {
        scalarset == .N || scalarset == .Z
    }
    
    public var isglobal10: Bool {
        nument.numeration.isglobal10
    }
    
   /* public init(_ facescalar:Facescalar) {
        minus = facescalar.minus
        scalarset = facescalar.set
        nument = SuiteChiffres(facescalar.nument, facescalar.numeration)
        dendec = SuiteChiffres(facescalar.dendec, facescalar.numeration)
        hasdot = facescalar.minus
    }*/

    public init(_ numer:Numeration,_ set:ScalarSet = .N){
        nument = SuiteChiffres(numer)
        dendec = SuiteChiffres(numer)
        scalarset = set
    }
    
    public init(_ set:ScalarSet){
        nument = SuiteChiffres(Numeration())
        dendec = SuiteChiffres(Numeration())
        scalarset = set
    }
    
    /*internal var clone:Scalar {
        let scalar = Scalar(nument.numeration, scalarset)
        scalar.set(self.real)
        scalar.firstselected = firstselected
        return scalar
    }*/
    
    mutating public func set(_ real:Real) {
        scalarset = real.set
        if !real.isNaN {
            let numeration = nument.numeration
            if real.isrelative {
                nument = SuiteChiffres(real.valint, numeration)
                dendec = SuiteChiffres(numeration)
            } else {
                if real.set == .Q {
                    nument = SuiteChiffres(real.rational.num, numeration)
                    dendec = SuiteChiffres(real.rational.den, numeration)
                } else {
                    refresh(real, numeration)
                  //  hasdot = !dendec.isNaN
                }
            }
        }
    }

    
    // initialisation à partir d'une SwiftReprésentation (.global,10)
    mutating internal func refresh(_ real:Real,_ numer:Numeration) {
        nument = SuiteChiffres(Numeration())
        dendec = SuiteChiffres(Numeration())
        scalarset = real.set
        firstselected = true       // pour commencer à remplir la partie entière
        
        // extraction des caractères de la réprésentation en base 10
        let input = real.g10chars
    
        for i in 0..<input.count {
            let car = input[i]
            if  car == "." {
                dot()
                firstselected = false
            } else {
                add(Int(String(car))!)
            }
        }
        if !numer.isglobal10 {
            convert(numer)
        }
    }
    
    // changement de numération et/ou de base
    internal func convert(_ numer: Numeration){
        // nota : le signe ne change pas
        nument.convert(numer)
        dendec.convert(numer)
    }
    
    mutating internal func convert(_ newset:ScalarSet) {
        if newset == .R && scalarset == .Q {
            self.set(Real(Double(nument.value) / Double(dendec.value)))
        }
        if newset == .Q && scalarset == .R {
            let puissance = dendec.puissance
            let num1 = nument.value * puissance + dendec.value
            let rat1 = Rational(num1, puissance)
            let fraction = neighbour()
            if fraction.den < rat1.den {
                let num2 = nument.value * fraction.den + fraction.num
                self.set(Real(num2, fraction.den))
            } else {
                self.set(Real(num1, puissance))
            }
        }
    }
    // calcul de la fraction la plus proche d'un décimal < 1
    // reste à affiner ?
    func neighbour() -> Rational {
        var decimales = dendec.decimales
        var result = Rational(0)
        for prime in primes {
            let rational = Rational(1, prime)
            let fraction = 1 / Double(prime)
            if decimales == fraction {
                return result.add(rational)
            } else {
                if decimales > fraction {
                    result = result.add(rational)
                    decimales -= fraction
                }
            }
        }
        return result
    }
    
    public var engroupes:[[[Int]]] {
        var groups = [nument.groupes(true)]
        if !dendec.isNaN {
            groups.append( dendec.groupes(scalarset == .Q) )
        }
        return groups
    }
    
    public var isgraphic: Bool {
        nument.numeration.isgraphic
    }
    public var isnul : Bool {
        return nument.isnul && dendec.isnul
    }
    public var isNaN : Bool {
        return nument.isNaN && dendec.isNaN
    }
    
    public var sature:Bool {
        return nument.sature || dendec.sature
    }
    
    // valeur en base 10
    public var real:Real {
        if scalarset == .N || scalarset == .Z {
            return Real(nument.value)
        } else {
            if scalarset == .Q {
                return Real(nument.value,dendec.value)
            } else {
                return Real(decimal)
            }
        }
    }
    
    public var relatif:Int {
        let value = (scalarset == .N || scalarset == .Z) ? nument.value : 0
        return minus ? -value : value
    }
    
    public var rational:Rational {
        var den = dendec.isNaN ? 1 : dendec.value
        if scalarset == .R {
            den = Int(1/den)    //======     approximation à corriger
        }
        return Rational(nument.value, den)
    }
    
    public var decimal:Double {
        var val = nument.entiere
        if scalarset == .R {
            val += dendec.decimales
        } else {
            if scalarset == .Q {
                val = Double(nument.value/dendec.value)
            }
        }
        return minus ? -val : val
    }
    // valeur absolue de la partie entière
   /* public var valint:Int {
        if numberset == .N || numberset == .Z {
            return minus ? -nument.value : nument.value
        } else {
            return Int(decimal)
        }
    }*/
    // valeur de la partie décimale  (sans signe puisqu'il est porté par la partie entière)
   /* public var valdec:Int {
        isrelative ? 0 : dendec.value
    }*/
    
    mutating public func reset() {
        nument.reset()
        dendec.reset()
        firstselected = true
        scalarset = .N
    }
    
    public func add(_ input:Int, _ additif:Bool = false){
        if firstselected {
            nument.add(input, additif)
        } else {
            dendec.add(input, additif)
        }
    }
    
    public var touchcount: Int{
        if firstselected {
            return nument.count
        } else {
            return dendec.count
        }
    }
    
    public var passlock : Bool {
        return firstselected ? nument.passlock : dendec.passlock
    }
    
    mutating public func select() {
        scalarset = .Q
        firstselected = false
    }
    
    mutating public func dot(){
        if nument.isNaN {
            nument.add(0)
        }
        scalarset = .R
       //hasdot = true
        firstselected = false
    }
    
}

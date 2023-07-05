//
//  Rational.swift
//  
//
//  Created by Herve Crespel on 15/02/2022.
//

// représentation Swift d'une valeur rationnelle par une fraction
public struct Rational {
    internal var num: Int = 0
    internal var den: Int = 1
    internal var isNaN = false
    
    
    public init(_ n:Int,_ d:Int = 1) {
        num = n
        let cp = commonprimes(n, d)
        if cp == [] {
            den = d
        } else {
            var rn = n
            var rd = d
            for i in 0..<cp.count {
                rn = rn / cp[i]
                rd = rd / cp[i]
            }
            num = rn
            den = rd
        }
    }
    
    // recomposition en fraction
   public init(_ decimal:Double) {
        // à corriger et compléter
       num = Int(decimal)
    }
    
    public init() {
        isNaN = true
    }
    
    public var real:Real {
        if den == 1 {
            return Real(num)
        } else {
            return Real(num / den)
        }
    }
    
    public func add(_ b:Rational)-> Rational{
        if den == b.den {
            return Rational(num + b.num, den)
        } else {
            let ppcm = ppcm(den, b.den)
            let mula = b.den / ppcm
            let mulb = den / ppcm
            return Rational(num * mula + b.num * mulb, ppcm * mula * mulb)
        }
    }
    
    public func substract(_ b:Rational)-> Rational{
        if den == b.den {
            return Rational(num - b.num, den)
        } else {
            let ppcm = ppcm(den, b.den)
            let mula = b.den / ppcm
            let mulb = den / ppcm
            return Rational(num * mula - b.num * mulb, ppcm * mula * mulb)
        }
    }
    
    public func multiply(_ b:Rational)-> Rational{
        return Rational(num * b.num, den * b.den)
    }
    
    public func divide(_ b:Rational)-> Rational{
        return Rational(num * b.den, den * b.num)
    }
    
    public var inverse: Rational{
        return Rational(den, num)
    }
    
    public var oppose: Rational{
        return Rational(-num, den)
    }
    
    private func ppcm(_ a:Int, _ b:Int)->Int {
        
        let cp = commonprimes(a, b)
        if cp.count == 0 {
            return 1
        } else {
            var cm = 1
            for i in 0..<cp.count {
                cm *= cp[i]
            }
            return cm
        }

    }
     // facteurs premiers communs
    private func commonprimes(_ a:Int, _ b:Int)->[Int] {
        var cp:[Int] = []

        for i in 0..<primes.count {
            let p = primes[i]
            if p > a || p > b {
                break
            } else {
                if a%p == 0 && b%p == 0 {
                    cp.append(p)
                }
            }
        }
        return cp
    }
}

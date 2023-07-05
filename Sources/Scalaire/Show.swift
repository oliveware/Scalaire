//
//  Scalarshow.swift
//
//
//  Created by Herve Crespel on 12/05/2022.
//

import Foundation

public struct Chiffres {
    // en chiffres unicode, en base native
    public var unicode : UnicodePresentation
    // en chiffres unicode, en base 10
    public var unico10 : UnicodePresentation
    // en chiffres graphiques
    public var graphical: GraphicPresentation

    public init(_ scalar:Scalar) {
       graphical = GraphicPresentation(scalar)
       unicode = UnicodePresentation(scalar)
        if scalar.isglobal10 {
            unico10 = unicode
        } else {
            var s10 = Scalar(Numeration())
            s10.set(scalar.real)
            unico10 = UnicodePresentation(s10)
        }
    }
}


public struct Lettres {

    // en toutes lettres en plusieurs langues
    public var litterals : [LitteralPresentation] = []
    public var tospeech : String = ""

    public init(_ value: Int = 0,_ langs:[Ecriture] = defaultscripts) {
        for i in 0..<langs.count {
            litterals.append(LitteralPresentation(value, langs[i]))
        }
        tospeech = String(value)
    }
}


// représentation de la valeur d'un nombre réel avec des caractères unicode
public struct UnicodePresentation {
    
    // en caractères unicode
    public var left : [String] = []
    public var dot = false
    public var right : [String] = []
    
    public init(_ scalar:Scalar){
        if !scalar.isNaN {
            left = scalar.nument.asleft
            if !scalar.dendec.isNaN {
                right = scalar.dendec.asright
            }
            dot = scalar.hasdot
        }
    }
    
    // pour les fractions
    public init(_ l:[String]) {
        left = l
    }
    
    // largeur en nombre de caractères
    public func barge(_ set:ScalarSet,_ gs:Int = 3) -> Int {
          let nbl = nbc(left)
          let nbr = nbc(right)
        if set == .Q {
            return nbl > nbr ? nbl : nbr
        } else {
            return nbl + nbr + (nbr > 0 ? 1 : 0)
        }
        func nbc(_ strings:[String]) -> Int {
            var l = 0
            for s in strings {
                l += s.count
            }
            return l + Int(l/gs)
        }
      }

}

// reprséentation de la valeur d'un nombre réel avec des graphismes calculés par programme.

public struct GraphicPresentation {
    
    // valeurs des touches pour composer les graphismes par programme
    public var left : [Int] = []
    public var dot = false
    public var right : [Int] = []
    public var vertical = false
    public var graphism : Graphism = .maya
        
    public init(_ scalar:Scalar) {
        if !scalar.isNaN {
            left = scalar.nument.touches
            if !scalar.dendec.isNaN {
                right = scalar.dendec.touches
            }
            dot = scalar.hasdot
        }
        
        graphism = scalar.nument.numeration.graphism
        vertical = (graphism == .maya)
    }
   
    // pour les fractions
    public init(_ l:[Int]) {
        left = l
    }
    
    public var nbc: Int {
        let nbl = left.count
        return right == [] ? nbl : nbl + right.count + 1
    }
}

// reprséentation de la valeur d'un nombre réel avec des graphismes calculés par programme.
//@available(iOS 13.0, *)

public struct Engroupes {
    
    // valeurs des touches pour composer les graphismes par programme
    public var left : [[Int]] = []
    public var dot = false
    public var right : [[Int]] = []
    public var vertical = false
    public var graphism : Graphism = .none
    public var groupby = 3
        
    public init(_ scalar:Scalar) {
        groupby = scalar.nument.numeration.groupby
        if !scalar.isNaN {
            touches = scalar.nument.touches
            left = split(toleft)
            if !scalar.dendec.isNaN {
                touches = scalar.dendec.touches
                if scalar.scalarset == .Q {
                    right = split(toleft)
                } else {
                    right = split(toright)
                }
            }
            dot = scalar.hasdot
        }
        
        graphism = scalar.nument.numeration.graphism
        vertical = (graphism == .maya)
    }
    private var toleft = true , toright = false
    private var touches: [Int] = []
    
    private func split(_ lor: Bool)-> [[Int]] {
        let nbdigits = touches.count
        var index = 0
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
    
    func extract(_ index: inout Int,_ nbdigits:Int)->[Int] {
        var group :[Int] = []
        for _ in 0..<nbdigits {
            group.append(touches[index])
            index += 1
        }
        return group
    }
}


// Traduction  l'écriture en toutes lettres
public struct LitteralPresentation {

    public var native : String = ""
    public var parle : String = ""
    public var romanise : String = ""
    public var alire : String = ""
    public var script : Ecriture
    
    public init(_ value:Int = 0,_ script:Ecriture){
        alire = String(value)
        self.script = script
        
        let langue = langues[script] ?? Langue(.fr, p:"fr-FR", r:.latin)
        let litteral = Litteral(value)
        
        native = litteral.enlettres(langue.native)
        parle = langue.parle

        // .bro n'est pas une romanisation !
        let roman = langue.romanise ?? .bro
        if roman == .bro {
            romanise = ""
        } else {
            romanise = litteral.enlettres(roman)
        }

    }
    
    // pour les previews
    public init(){
        native = "écriture native en toutes lettres"
        parle = "fr-FR"
        romanise = "écriture romanisée en toutes lettres"
        script = .fr
    }
    

}

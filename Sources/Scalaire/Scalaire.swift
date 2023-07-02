public struct Scalaire {
    
    var groupes : [Digigroup]
    
    public func chiffre(_ numic:Numicode, _ index:Int, _ power:Int = 0) -> Chiffre {
        
    }
    
    public func clavier(_ numic:Numicode, _ power:Int = 0) -> Clavier {
        
    }
    
    func glyphes(_ numic:Numicode, _ power:Int = 0) -> Glypheset {
        
    }

    public init() {
    }
}

public struct Digigroup {
    var power: Int
    var chiffres : [Chiffre]
}

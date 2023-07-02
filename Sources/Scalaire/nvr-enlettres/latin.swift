//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Latin: Litteral{
    var centaines = ["duocenti", "tricenti", "quadrigenti", "quingenti", "sescenti", "septingenti", "octingenti", "nongenti"]
    
    public override init(_ value: Int) {
        super.init(value)
     
        masculin = ["nulla", "unus", "duo", "tres", "quattuor", "quinque", "sex", "septem", "octo", "novem", "decem", "undecim", "duodecim", "tredecim", "quattuordecim", "quindecim", "sedecim", "septendecim", "duodeviginti", "undeviginti"]
        feminin = masculin
            
        dizaines = ["viginti", "triginta", "quadraginta", "quinquaginta", "sexaginta", "septuaginta", "octoginta", "nonaginta"]
            
        singrand = ["centum","mille","mille miliarum","mille miliarum miliarum"]
        plugrand = ["centi","milia","milia miliarum","milia miliarum miliarum"]
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let unite = n%10
        let dizaine = ((n-unite)/10)%10
        
        switch dizaine {
        case 0:
            return masculin[unite]
        case 1:
            return masculin[unite+10]
        default:
            switch unite{
            case 0:
                return dizaines[dizaine-2]
            case 8:
                if n%100 == 98 {
                    return "nonaginta octo"
                } else {
                    return "duode" + dizaines[dizaine-1]
                }
            case 9:
                if n%100 == 99 {
                    return "undecentum"
                } else {
                    return "unde" + dizaines[dizaine-1]
                }
            default:
                return dizaines[dizaine-2 ] + " " + masculin[unite]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let du = n%100 == 0 ? "" : dizunit(n%100)
     
        switch cent {
        case 0:
            return du
        case 1:
            if dizunit(n) == "99" {
                return "undecentum"
            } else {
                return "centum " + du
            }
            
        default:
            if dizunit(n) == "99" {
                return "unde" + centaines[cent-2]
            } else {
                return centaines[cent-2] + " " + du
            }
        }
    }
    
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return "mille " + cdu
        case 3:
            return "tria " + plugrand[1] + " " + cdu   // milia est neutre pluriel
        default:
            return construct(mil) + " " + plugrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        case 1:
            return singrand[2] + " " + mil(n%1000000)
        case 3:
            return "tria " + plugrand[2] + " " + mil(n%1000000)    // milia est neutre pluriel
        default:
            return construct(milmil) + " " + plugrand[2] + " " + mil(n%1000000)
        }
    }
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
         case 0:
             return million(n%1000000000)
         case 1:
             return singrand[3] + " " + million(n%1000000000)
         default:
             return construct(milmilmil) + " " + plugrand[3] + " " + million(n%1000000000)
        }
    }
}


public class Espagnol:Litteral{
    public override init(_ value: Int) {
        super.init(value)

       masculin = ["cero", "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve","diez","once","doce","trece","catorce", "quince", "dieciséis", "diecisiete","dieciocho","diecinueve"]
       feminin = masculin
       
        dizaines = ["veinte", "treinta", "cuarenta", "cincuenta", "sesenta", "setenta", "ochenta", "noventa"]
        singrand = ["cientos","mil","millones","mil millones", "billones", "mil billones"]     // milliard n'existe pas
       moins = "menos"
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return masculin[un]
        case 1:
            return masculin[10+un]
        case 2:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            case 1:
                return "veintiuno"
            case 2:
                return "veintidós"
            case 3:
                return "veintitrés"
            case 6:
                return "veintiséis"
            default:
                return dizaines[dizaine-2] + masculin[un]
            }
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            default:
                return dizaines[dizaine-2] + " y " + masculin[un]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10

        switch cent {
        case 0:
            return n%100 == 0 ? "" : dizunit(n)
        case 1:
            if n%100 == 0 {
                return "cien"
            } else {
                return "ciento " + dizunit(n)
            }
        default:
            if n%100 == 0 {
                return masculin[cent] + singrand[0]
            } else {
                return masculin[cent] + singrand[0] + dizunit(n)
            }
        }
    }
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        let cdu = n%1000 == 0 ? "" : " " + centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return singrand[1] +  cdu
        default:
            return construct(mil) + " " + singrand[1] +  cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        case 1:
            return "un millon " + mil(n%1000000)
        default:
            return construct(milmil) + " " + singrand[2] + " " + mil(n%1000000)
        }
    }
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
         case 0:
             return million(n%1000000000)
         case 1:
             return "mil " + million(n%1000000000)
         default:
             return million(milmilmil) + " mil " + million(n%1000000000)
        }
    }
    public override func billiard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
         case 0:
             return billion(n%1000000000)
         case 1:
             return " mil " + billion(n%1000000000)
         default:
             return million(milmilmil) + " mil " + billion(n%1000000000)
        }
    }
}


public class Francais:Litteral {
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["zéro", "un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf","dix","onze","douze","treize","quatorze", "quinze", "seize", "dix-sept","dix-huit","dix-neuf"]
        feminin = masculin
        feminin[1] = "une"
            
        dizaines = ["vingt", "trente", "quarante", "cinquante", "soixante", "soixante-dix", "quatre-vingt", "quatre-vingt-dix"]
        singrand = ["cent", "mille", "million", "milliard", "billion", "billiard", "trillion"]
        plugrand = ["cents" ,"mille","millions", "milliards", "billions", "billiards", "trillions"]
        
        moins = "moins"
        
        greatest = 1000000 * 1000000 * 1000000 - 1
    }

    
    public override func dizunit(_ n : Int, _ m :Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            if un == 0 {
                return ""
            } else {
                return masculin[un]
            }
        case 1:
            return masculin[10+un]
        case 6:
            switch un {
            case 0:
                return "soixante"
            case 1:
                return m ? "soixante-et-un" : "soixante-et-une"
            default:
                return "soixante-" + feminin[un]
            }
        case 7:
            switch un {
            case 0:
                return "soixante-dix" //dizaines[dizaine-2]
            case 1:
                return "soixante-et-onze" //dizaines[dizaine-3] + "-et-" + vingt[un+10]
            default:
                return dizaines[dizaine-3] + "-" + masculin[un+10]
            }
        case 8:
            if un == 0 {
                return "quatre-vingts"
            } else {
                return "quatre-vingt-" + (m ? masculin[un] : feminin[un])
            }
        case 9:
            if un == 0 {
                return dizaines[dizaine-2]
            } else {
                return dizaines[dizaine-3] + "-" + (m ? masculin[10+un] : feminin[un+10])
            }
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            case 1:
                return dizaines[dizaine-2] + "-et-" + (m ? masculin[1] :feminin[1])
            default:
                return dizaines[dizaine-2] + "-" + masculin[un]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m:Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
     
        switch cent {
        case 0:
            return dizunit(n)
        case 1:
            if n%100 == 0 {
                return singrand[0]
            } else {
                return singrand[0] + "-" + dizunit(n, m)
            }
            
        default:
            if n%100 == 0 {
                return feminin[cent] + "-cents"
            } else {
                return feminin[cent] + "-cent-" + dizunit(n, m)
            }
        }
    }
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return singrand[1] + " " + cdu
        case 80:
            return "quatre-vingt mille " + cdu
        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }

}

public class Italiano:Litteral{
    public override init(_ value: Int) {
        super.init(value)
       feminin = ["zero", "uno", "due", "tre", "quattro", "cinque", "sei", "sette", "otto", "nove","dieci","undici","dodici","tredici","quattordici", "quindici", "sedici", "diciassete","diciotto","diciannove"]
       masculin = ["zero", "uno", "due", "tre", "quattro", "cinque", "sei", "sette", "otto", "nove","dieci","undici","dodici","tredici","quattordici", "quindici", "sedici", "diciassete","diciotto","diciannove"]
       dizaines = ["venti", "trenta", "quuaranta", "cinquanta", "sessanta", "settanta", "ottanta", "novanta"]
       
       singrand = ["cento","mille","milione","miliardo","bilione","biliardo","trilione","triliardo"]
       plugrand = ["centi","mila","milioni","miliardi","bilioni","biliardi","trilioni","triliardi"]
       
       moins = "meno"
    greatest = 1000000 * 1000000 * 1000000 - 1
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return masculin[un]
        case 1:
            return masculin[10+un]
        case 2:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            case 1:
                return "ventuno"
            case 3:
                return "ventitré"
            case 8:
                return "ventotto"
            default:
                return dizaines[dizaine-2] + masculin[un]
            }
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            case 3:
                return dizaines[dizaine-2] + "tré"
            case 1,8:
                var diz = dizaines[dizaine-2]
                diz.remove(at:diz.index(before: diz.endIndex))
                return String(diz) + masculin[un]
            default:
                return dizaines[dizaine-2] + masculin[un]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10

        switch cent {
        case 0:
            return n%100 == 0 ? "" : dizunit(n)
        case 1:
            if n%100 == 0 {
                return "cento"
            } else {
                return "cento" + dizunit(n)
            }
        default:
            if n%100 == 0 {
                return masculin[cent] + "centi"
            } else {
                return masculin[cent] + "centi" + dizunit(n)
            }
        }
    }
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return "mille " + cdu
        default:
            return construct(mil) + plugrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        case 1:
            return "un milione " + mil(n%1000000)
        default:
            return construct(milmil) + " " + plugrand[2] + " " + mil(n%1000000)
        }
    }
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
         case 0:
             return million(n%1000000000)
         case 1:
             return "un miliardo " + million(n%1000000000)
         default:
             return construct(milmilmil) + " " + plugrand[3] + " " + million(n%1000000000)
        }
    }
}

public class Picard:Litteral {
    
    var centaines = ["deuchint", "trochint", "quatechint", "chinqchint", "sichint", "sètchint", "ûtchint", "nuéchint"]
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["zéro", "un", "deus", "tros", "quate", "chinq", "sis", "sièt", "ût", "nué", "dich", "onze", "douze", "treize", "catorze", "qhinze", "seize", "dis-sèt", "dis-ût", "dis-nué"]
        feminin = masculin
        feminin[1] = "eune"
            
        dizaines = ["vint", "trente", "quarante", "chonquante", "sissante", "sétante", "ûtante", "novante"]
        
        singrand = ["chint", "milliasse", "millionasse", "milliardasse"]
        
        moins = "moins"
    }
    
    public override func dizunit(_ n : Int, _ m :Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return masculin[un]
        case 1:
            return masculin[10+un]
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            case 1:
                return dizaines[dizaine-2] + "-et-" + (m ? masculin[1] :feminin[1])
            default:
                return dizaines[dizaine-2] + "-" + masculin[un]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m:Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
     
        switch cent {
        case 0:
            return n%100 == 0 ? "" : dizunit(n)
        case 1:
            if n%100 == 0 {
                return singrand[0]
            } else {
                return singrand[0] + "-" + dizunit(n, m)
            }
            
        default:
            if n%100 == 0 {
                return centaines[cent-2]
            } else {
                return centaines[cent-2] + "-" + dizunit(n, m)
            }
        }
    }
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return "eune " + singrand[1] + " " + cdu
        default:
            return construct(mil) + " " + singrand[1] + "s " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        case 1:
            return "eune " + singrand[2] + " " + mil(n%1000000)
        default:
            return construct(milmil) + " " + singrand[2] + "s " + mil(n%1000000)
        }
    }
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
         case 0:
             return million(n%1000000000)
         case 1:
             return "eune " + singrand[3] + " " + million(n%1000000000)
         default:
             return construct(milmilmil) + " " + singrand[3] + "s " + million(n%1000000000)
        }
    }
}


public class Portuguais:Litteral{
    public override init(_ value: Int) {
        super.init(value)

       masculin = ["zero", "um", "dois", "três", "quatro", "cinco", "seis", "sete", "oito", "nove","dez","onze","doze","treze","catorze", "quinze", "dezasseis", "dezzasete","dezoito","dezanove"]
       feminin = masculin
       
       dizaines = ["vinte", "trinta", "quarenta", "cinquenta", "sessenta", "setenta", "oitenta", "noventa"]
       singrand = ["cem","mil","milhão","mil milhões", "bilião", "mil bilhões"]     // pas de mot pour milliard
       plugrand = ["centos","mil","milhões","mil milhões", "bilhões", "mil bilhões"]
    greatest = 1000000 * 1000000 * 1000 - 1
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return masculin[un]
        case 1:
            return masculin[10+un]
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            default:
                return dizaines[dizaine-2] + " e " + masculin[un]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10

        switch cent {
        case 0:
            return n%100 == 0 ? "" : dizunit(n)
        case 1:
            if n%100 == 0 {
                return "cem"
            } else {
                return "cento e " + dizunit(n)
            }
        case 2:
            if n%100 == 0 {
                return "duzentos"
            } else {
                return "duzentos e " + dizunit(n)
            }
        case 3:
            if n%100 == 0 {
                return "trezentos"
            } else {
                return "trezentos e " + dizunit(n)
            }
        case 5:
            if n%100 == 0 {
                return "quinhentos"
            } else {
                return "quinhentos e " + dizunit(n)
            }
        default:
            if n%100 == 0 {
                return masculin[cent] + plugrand[0]
            } else {
                return masculin[cent] + plugrand[0] + " e " + dizunit(n)
            }
        }
    }
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        var cdu = ""
        switch n%1000 {
        case 0:
            cdu = centdizunit(n%1000)
        case 1...9:
            cdu = " e " + centdizunit(n%1000)
        default:
            cdu = (n%100 == 0 ? " e " : " ") + centdizunit(n%1000)
        }
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return singrand[1] + cdu
        default:
            return construct(mil) + " " + singrand[1] + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0:
            return mil(n%1000000)
       
        default:
            return construct(milmil) + " " + singrand[2] + " " + mil(n%1000000)
        }
    }
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
         case 0:
             return million(n%1000000000)
         case 1:
             return " mil " + million(n%1000000000)
         default:
             return mil(milmilmil) + " mil " + million(n%1000000000)
        }
    }
    public override func billiard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
         case 0:
             return billion(n%1000000000)
         case 1:
             return " mil " + billion(n%1000000000)
         default:
             return mil(milmilmil) + " mil " + billion(n%1000000000)
        }
    }
}

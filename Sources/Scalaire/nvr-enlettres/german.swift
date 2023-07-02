//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Afrikaans:Litteral{
    public override init(_ value: Int) {
        super.init(value)
        feminin = ["nul", "een", "twee", "drie", "vier", "vyf", "ses", "sewe", "ag", "nege", "tien", "elf", "twaalf", "dertien", "veertien", "vyftien", "sestien", "sewentien","agtien","negentien"]
        masculin = feminin
        dizaines = ["twintig", "dertig", "veertig", "vyftig", "sestig", "sewentig", "tagtig", "neëntig"]
        singrand = ["honderd", "duisend", "miljoen", "miljard", "biljoen"]
        plugrand = singrand
       
       moins = "minus"
    }
   
    public override func dizunit(_ n : Int, _ m:Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return m ? masculin[un] : feminin[un]
        case 1:
            return m ? masculin[10+un] : feminin[10+un]
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            default:
                return (m ? masculin[un] : feminin[un]) + "-en-" + dizaines[dizaine-2]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m:Bool = true)-> String {
        let cent = ((n-n%100)/100)%10

        switch cent {
        case 0:
            return n%100 == 0 ? "" : dizunit(n)
        default:
            if n%100 == 0 {
                return (m ? masculin[cent] : feminin[cent]) + singrand[0]
            } else {
                return (m ? masculin[cent] : feminin[cent]) + singrand[0] + " " + dizunit(n)
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
        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }

}


public class Alsacien:Litteral{
    public override init(_ value: Int) {
        super.init(value)

    masculin = ["null", "eins", "zwei", "drèï", "viar", "femf", "sex", "sewwa", "ååcht", "nîn","zeh","elf","zwelf","drize","viarze", "fùffze", "sæchze", "sewweze","åchtze","ninzeh"]
    feminin = masculin
        
    dizaines = ["zwånzig", "drissig", "viarzig", "fùffzig", "sæchzig", "sewwezig", "åchzig", "nînzig"]
    singrand = ["hùnd’rt","toisig","Million","Milliard"]
    plugrand = ["hùnd’rt","toisig","Millione","Milliarde"]
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
            case 1:
                return "eina" + dizaines[dizaine-2]
            default:
                return masculin[un] + "a" + dizaines[dizaine-2]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10

        switch cent {
        case 0:
            return dizunit(n)
        case 1:
            if n%100 == 0 {
                return singrand[0]
            } else {
                return singrand[0] + dizunit(n)
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
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return singrand[1] + cdu
        default:
            return construct(mil) + singrand[1] + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        let mili = n%1000000 == 0 ? "" : " " + mil(n%1000000)
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        case 1:
            return "e " + singrand[2] + mili
        default:
            return construct(milmil) + " " + plugrand[2] + mili
        }
    }
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        let milli = n%1000000000 == 0 ? "" :  million(n%1000000000)
        
        switch milmilmil {
         case 0:
             return million(n%1000000000)
         case 1:
             return singrand[1] + milli
         default:
            if milmilmil < 1000 {
                return mil(milmilmil) + singrand[1] + milli
            } else {    // limite 999 999 999 millions
                let milmilliard = milmilmil%1000
                let milmilmilmil = (milmilmil - milmilliard)/1000
                return mil(milmilmilmil) + singrand[1] + mil(milmilliard) + singrand[1] + milli
            }
        }
    }
}


public class Amish:Litteral{
    public override init(_ value: Int) {
        super.init(value)

    masculin = ["null", "eens", "zwee", "drei", "vier", "fimf", "sex", "siwwe", "acht", "nein","zehe","elf","zwelf","dreizeh","vazen", "fuffzeh", "sechzeh", "siwwezeh","achtzeh","neinzeh"]
    feminin = masculin
        
    dizaines = ["zwansich", "dreissich", "vazich", "fuffzich", "sechzich", "siwwezich", "achtzich", "neinzich"]
    singrand = ["hunnert","dausend","millyon","Milliard"]
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
            case 1:
                return "eenun" + dizaines[dizaine-2]
            default:
                return masculin[un] + "un" + dizaines[dizaine-2]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10

        switch cent {
        case 0:
            return dizunit(n)
        case 1:
            return "en " + dizunit(n)
        default:
            if n%100 == 0 {
                return masculin[cent] + " " + singrand[0]
            } else {
                if n%100 < 10 {
                    return masculin[cent] + " " + singrand[0] + " un " + dizunit(n)
                } else {
                    return masculin[cent] + " " + singrand[0] + " " + dizunit(n)
                }
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
            return "en" + singrand[1] + " " + cdu
        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let nbmillion = (n-n%1000000)/1000000
        let mili = n%1000000 == 0 ? "" : " " + mil(n%1000000)
        
        // nbmillion < 1000
        switch nbmillion {
        case 0:
            return mil(n%1000000)
        case 1:
            return "en " + singrand[2] + mili
        default:
            return mil(nbmillion) + " " + singrand[2] + mili
        }
    }
    public override func milliard(_ n:Int)-> String {
        let nbmilliard = (n-n%1000000000)/1000000000

        let milli = n%1000000000 == 0 ? "" : " " + million(n%1000000000)
        
        // nbmillion < 1000000
        switch nbmilliard {
        case 0:
            return million(n%1000000000)
        case 1:
            return "en " + singrand[1] + milli
        default:
              return mil(nbmilliard) + " " + milli
        }
    }
    public override func billion(_ n:Int)-> String {
        let nbillion = (n-n%1000000000000)/1000000000000

        let billi = n%1000000000000 == 0 ? "" : " " + million(n%1000000000000)
        
        switch nbillion {
        case 0:
            return milliard(n%1000000000000)
        case 1:
            return "en " + singrand[1] + billi
        default:
              return mil(nbillion) + " " + billi
        }
    }
    public override func billiard(_ n:Int)-> String {
        let nbilliard = (n-n%1000000000000000)/1000000000000000

        let billi = n%1000000000000000 == 0 ? "" : " " + million(n%1000000000000000)
        
        switch nbilliard {
        case 0:
            return billion(n%1000000000000)
        case 1:
            return "en " + singrand[1] + billi
        default:
              return mil(nbilliard) + " " + billi
        }
    }
}



public class Deutsch:Litteral{
    public override init(_ value: Int) {
        super.init(value)

    masculin = ["null", "eins", "zwei", "drei", "vier", "fünf", "sechs", "sieben", "acht", "neun","zehn","elf","zwölf","dreizehn","vierzehn", "fünfzehn", "sechzehn", "siebenzehn","achtzehn","neunzehn"]
    feminin = masculin
        
    dizaines = ["zwanzig", "dreißig", "vierzig", "fünfzig", "sechzig", "siebzig", "achzig", "neunzig"]
    singrand = ["hundert","tausend","Million","Milliarde","Billion","Billiarde","Trillion","Trilliarde"]
        plugrand = singrand
    moins = "minus"
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
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            case 1:
                return "einund" + dizaines[dizaine-2]
            default:
                return masculin[un] + "und" + dizaines[dizaine-2]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10

        switch cent {
        case 0:
            return dizunit(n)
        case 1:
            if n%100 == 0 {
                return "ein" + singrand[0]
            } else {
                return "ein" + singrand[0] + dizunit(n)
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
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return "ein" + singrand[1] + cdu
        default:
            return construct(mil) + singrand[1] +  cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        let mili = n%1000000 == 0 ? "" : " " + mil(n%1000000)
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        case 1:
            return "eine " + singrand[2] + mili
        default:
            return construct(milmil) + " " + singrand[2] + "en" + mili
        }
    }
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        let milli = n%1000000000 == 0 ? "" : " " + million(n%1000000000)
        
        switch milmilmil {
         case 0:
             return million(n%1000000000)
         case 1:
             return "eine " + singrand[3] + milli
         default:
             return construct(milmilmil) + " " + singrand[3] + "n" + milli
        }
    }
}


public class Dutch:Litteral{
    public override init(_ value: Int) {
        super.init(value)
       masculin = ["nul", "één", "twee", "drie", "vier", "vijf", "zes", "zeven", "acht", "negen", "tien", "elf", "twaalf", "dertien", "veertien", "vijftien", "zestien", "zeventien","achttien","negentien"]
       feminin = masculin
       
       dizaines = ["twintig", "dertig", "veertig", "vijftig", "zestig", "zeventig", "tachtig", "negentig"]
       singrand = ["honderd","duizend","miljoen","miljard","biljoen","biljard"]
        plugrand = singrand
        greatest = 1000000 * 1000000 * 1000 - 1
    }
   
    public override func dizunit(_ n : Int, _ m:Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return m ? masculin[un] : feminin[un]
        case 1:
            return m ? masculin[10+un] : feminin[10+un]
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            case 2:
                return (m ? masculin[2] : feminin[2]) + "ën" + dizaines[dizaine-2]
            default:
                return (m ? masculin[un] : feminin[un]) + "en" + dizaines[dizaine-2]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m:Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let du = n%100 == 0 ? "" :  dizunit(n%100, m)

        switch cent {
        case 0:
            return du
        case 1:
            return singrand[0] + du
        default:
            return (m ? masculin[cent] : feminin[cent]) + singrand[0] + du

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
        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        case 1:
            return "een " + singrand[2] + " " + mil(n%1000000)
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
             return "een " + singrand[3] + " " + million(n%1000000000)
         default:
             return construct(milmilmil) + " " + singrand[3] + "s " + million(n%1000000000)
        }
    }
}


public class English:Litteral{
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine","ten","eleven","twelve","thirteen","fourteen", "fifteen", "sixteen", "seventeen","eighteen","nineteen"]
       feminin = masculin
            
       dizaines = ["twenty", "thirty", "fourty", "fifty", "sixty", "seventy", "eighty", "ninety"]
       singrand = ["hundred","thousand","million","billion"]
       
       moins = "minus"
    }
    
    public override func dizunit(_ n : Int, _ m:Bool = true)-> String {
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
                return dizaines[dizaine-2] + "-" + masculin[un]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m:Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let conj = n%100 == 0 ? "" : " and "
        let du = n%100 == 0 ? "" : dizunit(n%100)
        switch cent {
        case 0:
            return du
        case 1:
            if n==100 {
                return "one hundred"
            }else {
                return "one " + singrand[0] + conj + du
            }
        default:
            if n%100 == 0 {
                return masculin[cent] + " hundred"
            } else {
                return masculin[cent] + " " + singrand[0]  + conj + du
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
            return "one " + singrand[1] + " " + cdu
        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        case 1:
            return "one " + singrand[2] + " " + mil(n%1000000)
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
             return "one " + singrand[3] + " " + million(n%1000000000)
         default:
             return construct(milmilmil) + " " + singrand[3] + "s " + million(n%1000000000)
        }
    }
}

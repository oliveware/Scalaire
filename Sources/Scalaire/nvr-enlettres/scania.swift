//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Bokmal:Litteral {
    
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["nul", "én", "to", "tre", "fire", "fem", "seks", "sju", "åtte", "ni", "ti", "elleve", "tolv", "tretten", "fjorten", "femten", "seksten", "sytten", "atten", "nitten"]
        feminin = masculin
        dizaines = ["tjue", "tretti", "førti", "femti", "seksti", "sytti", "åtti", "nitti"]
        
        singrand = ["hundre", "tusen", "million", "milliard", "billion", "billiard"]
        plugrand = ["hundre", "tusen", "millioner", "milliarder", "billioner", "billiarder"]
        greatest = 1000000 * 1000000 * 1000 - 1
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return m ? masculin[un] : feminin[un]
        case 1:
            return m ? masculin[10+un] :feminin[10+un]
        
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            default:
                let du = m ? masculin[un] : feminin[un]
                return dizaines[dizaine-2] + du
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
     
        switch cent {
        case 0:
            return dizunit(n, m)
        case 1:
            if n%100 == 0 {
                return "ett " + singrand[0]
            } else {
                return "ett " + singrand[0] + " " + dizunit(n, m)
            }
            
        default:
            if n%100 == 0 {
                return masculin[cent] + " " + plugrand[0]
            } else {
                return masculin[cent] + " " + plugrand[0] + " " + dizunit(n, m)
            }
        }
    }
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        let log = n%1000 < 100 ? " og " : " "
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return "ett " + singrand[1] + log + cdu

        default:
            return construct(mil) + " " + plugrand[1] + log + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        let log = n%1000000 < 100000 ? " og " : " "
        switch milmil {
        case 0 :
            return mil(n%1000000)
        case 1:
            return "én " + singrand[2] + log + mil(n%1000000)
        case 2:
            return masculin[2] + " " + plugrand[2] + log + mil(n%1000000)
        default :
             let reste = milmil%1000
             if reste == 1 || reste == 2 {
                 return masculin[reste] + " " + plugrand[2] + log + mil(n%1000000)
             } else {
                 return construct(milmil) + " " + plugrand[2] + log + mil(n%1000000)
             }
        }
    }
        
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        let log = n%1000000000 < 100000000 ? " og " : " "
        
        switch milmilmil {
        case 0:
             return million(n%1000000000)
        case 1:
            return "én " + singrand[3] + log + million(n%1000000000)
        case 2:
            return masculin[2] + " " + plugrand[3] + log + million(n%1000000000)
        default:
            let reste = milmilmil%10
            if reste == 1 || reste == 2 {
                return masculin[reste] + " " + plugrand[3] + log + million(n%1000000000)
            } else {
                return construct(milmilmil) + " " + plugrand[3] + log + million(n%1000000000)
            }
        }
    }
}

public class Islande:Litteral {
    
    // La conjonction og est utilisée une seule fois par nombre et lie les deux dernières unités,
    var ogused = false
    var log : String {
        if ogused {
            return " "
        } else {
            ogused = true
            return " og "
        }
    }
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["núll", "einn", "tveir", "þrír", "fjórir", "fimm", "sex", "sjö", "átta", "niu", "tíu", "ellefu", "tólf", " þréttán", "fjórtán", "fimmtán", "sextán", "sautján", "átján", "nitján"]
        feminin = masculin
        feminin[1] = "ein"
        feminin[2] = "tvær"
        feminin[3] = "þrjár"
        feminin[4] = "fjórar"
        
        neutre = masculin
        neutre[1] = "eitt"
        neutre[2] = "tvö"
        neutre[3] = "þrjú"
        neutre[4] = "fjögur"
            
        dizaines = ["tuttugu", "þrjátíu", "fjórutíu", "fimmtíu", "sextíu", "sjötíu", "áttatíu", "níutíu"]
        singrand = ["hundrað", "þúsund", "ein miljón", "einn miljarður", "en biljon", "en biljarður"]
        plugrand = ["hundruð", "tusinde", "millioner", "milliarder", "billioner", "billiarder"]
        greatest = 1000000 * 1000000 * 1000 - 1
        moins = "mínus"
        
        ogused = false
        
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
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
                let u = m ? masculin[un] : feminin[un]
                return dizaines[dizaine-2] + log + u
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let du = dizunit(n, m) == "" ? "" : log + dizunit(n, m)
     
        switch cent {
        case 0:
            return n%100 == 0 ? "" : dizunit(n, m)
        case 1:
            if n%100 == 0 {
                return singrand[0]
            } else {
                return singrand[0] + du
            }
            
        default:
            if n%100 == 0 {
                return masculin[cent] + " " + plugrand[0]
            } else {
                return masculin[cent] + " " + plugrand[0] + du
            }
        }
    }
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        
        let cdu = n%1000 == 0 ? "" : log + centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return singrand[1] + " " + cdu
            
        default:
            return construct(mil) + " " + plugrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        let mcdu = n%1000000 == 0 ? "" : log + mil(n%1000000)
        
        switch milmil {
        case 0 :
            return mil(n%1000000)
        case 1:
            return singrand[2] + " " + mil(n%1000000)
        case 2:
            return masculin[2] + " " + plugrand[2] + mcdu
        default :
             let reste = milmil%10
             if reste == 1 || reste == 2 {
                 return masculin[reste] + " " + plugrand[2] + mcdu
             } else {
                 return construct(milmil) + " " + plugrand[2] + mcdu
             }
        }
    }
        
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
        case 0:
             return million(n%1000000000)
        case 1:
            return singrand[3] + " " + million(n%1000000000)
        case 2:
            return masculin[2] + " " + plugrand[3] + log + million(n%1000000000)
        default:
            let reste = milmilmil%10
            if reste == 1 || reste == 2 {
                return masculin[reste] + " " + plugrand[3] + log + million(n%1000000000)
            } else {
                return construct(milmilmil) + " " + plugrand[3] + log + million(n%1000000000)
            }
        }
    }
}

public class Letton:Litteral {
    
    var liaison = " "
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["nulle", "viens", "divi", "trïs", "četri", "pieci", "seši", "septini", "astoni", "devini", "desmit", "vienpadsmit", "divpadsmit","trïspadsmitt"," četrpadsmit", "piecpadsmit", "sešpadsmit", "septinpadsmit","astonpadsmit","devinpadsmit"]
        feminin = ["nulle", "viena", "divas", "trïs", "četras", "piecas", "sešas", "septinas", "astonas", "devinas", "desmit", "vienpadsmit", "divpadsmit","trïspadsmitt"," četrpadsmit", "piecpadsmit", "sešpadsmit", "septinpadsmit","astonpadsmit","devinpadsmit"]
        dizaines = ["divdesmit", "trïsdesmit", "četrdesmit", "piecdesmit", "sešdesmit", "septindesmit", "astondesmit", "devindesmit"]
        singrand = ["simts", "tūkstoš", "miljon", "miljard", "triljon", "kvadriljon"]
        plugrand = ["simti", "tūkstoši", "miljoni", "miljardi", "triljoni", "kvadriljoni"]
        greatest = 1000000 * 1000000 * 1000 - 1
        moins = "mīnus"
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return m ? masculin[un] : feminin[un]
        case 1:
            return m ? masculin[10+un] :feminin[10+un]
        
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            default:
                let du = m ? masculin[un] : feminin[un]
                return dizaines[dizaine-2] + liaison + du
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
     
        switch cent {
        case 0:
            return n%100 == 0 ? "" : dizunit(n, m)
        case 1:
            if n%100 == 0 {
                return singrand[0]
            } else {
                return singrand[0] + " " + dizunit(n, m)
            }
            
        default:
            if n%100 == 0 {
                return masculin[cent] + " " + plugrand[0]
            } else {
                return masculin[cent] + " " + plugrand[0] + " " + dizunit(n, m)
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
            return construct(mil) + " " + plugrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0 :
            return mil(n%1000000)
        case 1:
            return masculin[1] + " " + singrand[2] + " " + mil(n%1000000)
        case 2:
            return masculin[2] + " " + plugrand[2] + " " + mil(n%1000000)
        default :
             let reste = milmil%10
             if reste == 1 || reste == 2 {
                 return masculin[reste] + " " + plugrand[2] + " " + mil(n%1000000)
             } else {
                 return construct(milmil) + " " + plugrand[2] + " " + mil(n%1000000)
             }
        }
    }
        
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
        case 0:
             return million(n%1000000000)
        case 1:
            return masculin[1] + " " + singrand[3] + " " + million(n%1000000000)
        case 2:
            return masculin[2] + " " + plugrand[3] + " " + million(n%1000000000)
        default:
            let reste = milmilmil%10
            if reste == 1 || reste == 2 {
                return feminin[reste] + " " + plugrand[3] + " " + million(n%1000000000)
            } else {
                return construct(milmilmil) + " " + plugrand[3] + " " + million(n%1000000000)
            }
        }
    }
}

public class Danois:Litteral {
    
    public override init(_ value: Int) {
        super.init(value)
            
        masculin = ["null", "en", "to", "tre", "fire", "fem", "seks", "syv", "otte", "ni", "ti", "elleve", "tolv", "tretten", "fjorten", "femten", "seksten", "sytten", "atten", "nitten"]
        feminin = masculin
            
        dizaines = ["tyve", "tredive", "fyrre", "halvtreds", "tres", "halvfjerds", "firs", "halvfems"]
        
        singrand = ["hundred", "et tusind", "en million", "en milliard", "en billion", "en billiard"]
        plugrand = ["hundrede", "tusinde", "millioner", "milliarder", "billioner", "billiarder"]
        greatest = 1000000 * 1000000 * 1000 - 1
        moins = "minus"
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return m ? masculin[un] : feminin[un]
        case 1:
            return m ? masculin[10+un] :feminin[10+un]
        
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            default:
                let du = m ? masculin[un] : feminin[un]
                return du + "og" + dizaines[dizaine-2]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        
        let du = n%100 == 0 ? "" : " " + dizunit(n%100)
     
        switch cent {
        case 0:
            return du
        case 1:
            if n%100 == 0 {
                return singrand[0]
            } else {
                return singrand[0] + du
            }
            
        default:
            if n%100 == 0 {
                return masculin[cent] + " " + plugrand[0]
            } else {
                return masculin[cent] + " " + plugrand[0] + du
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
            return construct(mil) + " " + plugrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0 :
            return mil(n%1000000)
        case 1:
            return singrand[2] + " " + mil(n%1000000)
        case 2:
            return masculin[2] + " " + plugrand[2] + " " + mil(n%1000000)
        default :
             let reste = milmil%10
             if reste == 1 || reste == 2 {
                 return masculin[reste] + " " + plugrand[2] + " " + mil(n%1000000)
             } else {
                 return construct(milmil) + " " + plugrand[2] + " " + mil(n%1000000)
             }
        }
    }
        
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
        case 0:
             return million(n%1000000000)
        case 1:
            return singrand[3] + " " + million(n%1000000000)
        case 2:
            return masculin[2] + " " + plugrand[3] + " " + million(n%1000000000)
        default:
            let reste = milmilmil%10
            if reste == 1 || reste == 2 {
                return masculin[reste] + " " + plugrand[3] + " " + million(n%1000000000)
            } else {
                return construct(milmilmil) + " " + plugrand[3] + " " + million(n%1000000000)
            }
        }
    }
}


public class Estonie:Litteral {
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["null", "üks", "kaks", "kolm", "neli", "viis", "kuus", "seitse", "kaheksa", "üheksa", "kümme", "ükteist", "kaksteist", "kolmteist", "neliteist", "viisteist", "kuusteist", "seitseteist", "kaheksateist", "üheksateist"]
        feminin = masculin
        
        dizaines = ["kakskümmend", "kolmkümmend", "nelikümmend", "viiskümmend", "kuuskümmend", "seitsekümmend", "kaheksakümmend", "üheksakümmend"]
        
        singrand = ["sada", "tuhat", "miljon", "miljard", "triljon", "kvadriljon", "kvintiljon", "sekstiljon"]
        plugrand = ["sada", "tuhat", "miljonit", "miljardit", "triljonit", "kvadriljonit", "kvintiljonit", "sekstiljonit"]
        greatest = 1000000 * 1000000 * 1000000 - 1
        moins = "miinus"
        
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return m ? masculin[un] : feminin[un]
        case 1:
            return m ? masculin[10+un] :feminin[10+un]
        
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            default:
                let du = m ? masculin[un] : feminin[un]
                return dizaines[dizaine-2] + " " + du
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let du = n%100 == 0 ? "" : " " + dizunit(n%100, m)
     
        switch cent {
        case 0:
            return du
        case 1:
            if n%100 == 0 {
                return singrand[0]
            } else {
                return singrand[0] + du
            }
            
        default:
            if n%100 == 0 {
                return masculin[cent] + singrand[0]
            } else {
                return masculin[cent] + singrand[0] + du
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
            return construct(mil) + " " + plugrand[1] + " " + cdu
        }
    }
 
}


public class Lituanie:Litteral {
    
    var liaison = " "
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["nulis", "vienas", "du", "trys", "keturi", "penki", "šeši", "septyni", "aštuoni", "devyni", "dešimt", "vienuolika", "dvylika","trylika"," keturiolika", "penkiolika", "šešiolika", "septyniolika","aštuoniolika","devyniolika"]
        feminin = ["nulis", "viena", "dvi", "trys", "keturios", "penkios", "šešios", "septynios", "aštunios", "devynios", "dešimt", "vienuolika", "dvylika","trylika"," keturiolika", "penkiolika", "šešiolika", "septyniolika","aštuoniolika","devyniolika"]
        dizaines = ["dvidešimt", "trisdešimt", "keturiadešimt", "penkiadešimt", "šešiasdešimt", "septyniadešimt", "astuoniadešimt", "devyniadešimt"]
        
        singrand = ["šimtas", "tūkstantis", "miljonas", "miljardas", "triljonas", "kvadriljonas"]
        plugrand = ["šimtai", "tūkstančiai", "miljonai", "miljardai", "triljonai", "kvadriljonai"]
        greatest = 1000000 * 1000000 * 1000 - 1
        moins = "minus"
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return m ? masculin[un] : feminin[un]
        case 1:
            return m ? masculin[10+un] :feminin[10+un]
        
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            default:
                let du = m ? masculin[un] : feminin[un]
                return dizaines[dizaine-2] + liaison + du
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
     
        switch cent {
        case 0:
            return n%100 == 0 ? "" : dizunit(n, m)
        case 1:
            if n%100 == 0 {
                return singrand[0]
            } else {
                return singrand[0] + " " + dizunit(n, m)
            }
            
        default:
            if n%100 == 0 {
                return masculin[cent] + " " + plugrand[0]
            } else {
                return masculin[cent] + " " + plugrand[0] + " " + dizunit(n, m)
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
            return construct(mil) + " " + plugrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0 :
            return mil(n%1000000)
        case 1:
            return masculin[1] + " " + singrand[2] + " " + mil(n%1000000)
        case 2:
            return masculin[2] + " " + plugrand[2] + " " + mil(n%1000000)
        default :
             let reste = milmil%10
             if reste == 1 || reste == 2 {
                 return masculin[reste] + " " + plugrand[2] + " " + mil(n%1000000)
             } else {
                 return construct(milmil) + " " + plugrand[2] + " " + mil(n%1000000)
             }
        }
    }
        
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
        case 0:
             return million(n%1000000000)
        case 1:
            return masculin[1] + " " + singrand[3] + " " + million(n%1000000000)
        case 2:
            return masculin[2] + " " + plugrand[3] + " " + million(n%1000000000)
        default:
            let reste = milmilmil%10
            if reste == 1 || reste == 2 {
                return masculin[reste] + " " + plugrand[3] + " " + million(n%1000000000)
            } else {
                return construct(milmilmil) + " " + plugrand[3] + " " + million(n%1000000000)
            }
        }
    }
}


public class Suedois:Litteral {
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["noll", "en", "två", "tre", "fyra", "fem", "sex", "sju", "åtta", "nio", "tio", "elva", "tolv", "tretton", "fjorton", "femton", "sexton", "sjutton", "arton", "nitton"]
        feminin = masculin

        dizaines = ["tjugo", "trettio", "fyrtio", "femtio", "sextio", "sjuttio", "åttio", "nittio"]
        
        singrand = ["hundra", "tusen", "miljon", "miljard", "biljon"]
        plugrand = ["hundra", "tusen", "miljoner", "miljarder", "biljoner"]
        greatest = 1000000 * 1000000 - 1
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
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
                let du = m ? masculin[un] : feminin[un]
                return dizaines[dizaine-2] + du
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let du = n%100 == 0 ? "" :  dizunit(n%100, m)
        
        switch cent {
        case 0:
            return du
        case 1:
            return singrand[0] +  du
        default:
            if n%100 == 0 {
                return masculin[cent] + singrand[0]
            } else {
                return masculin[cent] + singrand[0] + du
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
            return singrand[1] + cdu

        default:
            return construct(mil) + singrand[1] + cdu
        }
    }
    
}

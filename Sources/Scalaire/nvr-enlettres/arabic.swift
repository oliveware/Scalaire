//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Arabe:Litteral {
    
    var centaines = ["mi'a", "miayatayn", "thalathimia", "'arbae mia", "khamsumiaya", "situmiaya", "sabeumiaya", "thamanimiaya", "tise miaya"]
    var wa = " wa-"
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["sifr", "wahid", "ithnan", "thalatha", "arba'a", "khamsa", "sitta", "sab'a", "thamaniya", "tis'a", "'ashra", "ahada 'ashar", "ithna 'ashar","thalatha 'ashar", "arba'a 'ashar", "khamsa 'ashar", "sitta 'ashar", "sab'a 'ashar", "thamaniya 'ashar", "tis'a 'ashar"]
        feminin = ["sifr", "wahid", "ithnan", "thalatha", "arba'a", "khamsa", "sitta", "sab'a", "thamaniya", "tis'a", "'asharat", "ahada 'asharat", "ithna 'asharat","thalatha 'asharat", "arba'a 'asharat", "khamsa 'asharat", "sitta 'asharat", "sab'a 'asharat", "thamaniya 'asharat", "tis'a 'asharat"]

        dizaines = ["'ishrun", "thalathun", "arba'un", "khamsun", "sittun", "sab'un", "thamanun", "tis'un"]
        
        singrand = ["mi'a", "alf", "malioun", "maliâr"]
        plugrand = ["mi'a", "alaaf", "malâyîn", "maliâr"]
            
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
                return du + wa + dizaines[dizaine-2]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let du = n%100 == 0 ? "" : dizunit(n%100, m)
        
        switch cent {
        case 0:
            return du
        case 1:
            return singrand[0] + wa + du
        default:
            if n%100 == 0 {
                return masculin[cent] + " " + singrand[0]
            } else {
                return masculin[cent] + " " + singrand[0] + wa + du
            }
        }
    }
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        
        let cdu = n%1000 == 0 ? "" : wa + centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return singrand[0] + cdu
        case 2...9 :
            return construct(mil) + " alaaf " + cdu
        default:
            return construct(mil) + " alf " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0 :
            return mil(n%1000000)
        case 1:
            return singrand[2] + wa + mil(n%1000000)
        default :
            return construct(milmil) + " " + singrand[2] + wa + mil(n%1000000)
        }
    }
        
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
        case 0:
             return million(n%1000000000)
        case 1:
            return singrand[3] + wa + million(n%1000000000)

        default:
            return construct(milmilmil) + " " + singrand[3] + wa + million(n%1000000000)
        }
    }
}

public class Arabic: Arabe {     // non opérant
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["صفر", "یک", "دو", "три", "четири", "пет", "шест", "седем", "осем", "девет", "десет", "еднонадесет", "двенадесет", "тринадесет", "четиринадесет", "петнадесет", "шестнадесет", "седемнадесет", "осемнадесет", "деветнадесет"]
        feminin = masculin
        
        dizaines = ["двадесет", "тридесет", "четиридесет", "петдесет", "шестдесет", "седемдесет", "осемдесет", "деветдесет"]
        centaines = ["сто","двеста","триста", "четиристотин", "петстотин", "шестстотин", "седемстотин", "осемстотин", "деветстотин"]
        
        singrand = ["هزار", "میلیون" ,"صد"]
        
        wa = " و "
    }
}

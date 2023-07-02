//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Bulgare:Litteral {
    
    var centaines = ["sto", "dvesta", "trista", "chetiristotin", "petstotin", "sheststotin", "sedenstotin", "osemstotin", "devetstotin"]
    var liaison = " i "
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["nula", "edin", "dva", "tri", "chetiri", "pet", "shest", "sedem", "osem", "devet", "deset", "edinadeset", "dvanadeset","trinadeset","chetirinadeset", "petnadeset", "shestnadeset", "sedemnadeset","osemnadeset","devetnadeset"]
        feminin = masculin
        feminin[1] = "edno"
        feminin[2] = "dve"
        dizaines = ["dvadeset", "trideset", "chetirideset", "petdeset", "shestdeset", "sedemdeset", "osemdeset", "devetdeset"]
        
        singrand = ["hilyada","milion","miliard"]
        plugrand = ["hilyadi","miliona","miliarda"]
            
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
        let du = n%100 == 0 ? "" : " " + dizunit(n%100, m)
     
        switch cent {
        case 0:
            return du
        case 1:
            if n%100 == 0 {
                return centaines[0]
            } else {
                return centaines[0] + du
            }
            
        default:
            if n%100 == 0 {
                return centaines[cent-1]
            } else {
                return centaines[cent-1] + du
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
            return singrand[0] + " " + cdu

        default:
            return construct(mil) + " " + plugrand[0] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0 :
            return mil(n%1000000)
        case 1:
            return feminin[1] + " " + singrand[1] + " " + mil(n%1000000)
        case 2:
            return feminin[2] + " " + plugrand[1] + " " + mil(n%1000000)
        default :
             let reste = milmil%10
             if reste == 1 || reste == 2 {
                 return feminin[reste] + " " + plugrand[1] + " " + mil(n%1000000)
             } else {
                 return construct(milmil) + " " + plugrand[1] + " " + mil(n%1000000)
             }
        }
    }
        
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
        case 0:
             return million(n%1000000000)
        case 1:
            return feminin[1] + " " + singrand[2] + " " + million(n%1000000000)
        case 2:
            return feminin[2] + " " + plugrand[2] + " " + million(n%1000000000)
        default:
            let reste = milmilmil%10
            if reste == 1 || reste == 2 {
                return feminin[reste] + " " + plugrand[2] + " " + million(n%1000000000)
            } else {
                return construct(milmilmil) + " " + plugrand[2] + " " + million(n%1000000000)
            }
        }
    }
}

public class BulgareCyrillic:Bulgare{
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["нула", "еднн", "двa", "три", "четири", "пет", "шест", "седем", "осем", "девет", "десет", "еднонадесет", "двенадесет", "тринадесет", "четиринадесет", "петнадесет", "шестнадесет", "седемнадесет", "осемнадесет", "деветнадесет"]
        feminin = masculin
        feminin[1] = "едио"
        feminin[2] = "двe"
        
        dizaines = ["двадесет", "тридесет", "четиридесет", "петдесет", "шестдесет", "седемдесет", "осемдесет", "деветдесет"]
        centaines = ["сто","двеста","триста", "четиристотин", "петстотин", "шестстотин", "седемстотин", "осемстотин", "деветстотин"]
        
        plugrand = ["хиляди", "милиона", "милиарда"]
        singrand = ["хиляда", "милион", "милиард"]
        
        moins = "минус"
        
        liaison = " и "
    }
}

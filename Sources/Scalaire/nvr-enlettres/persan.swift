//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Persan:Litteral {
    
    var centaines = ["sad", "devist", "sisad", "chahârsad", "pansad", "sheshsad", "heftsad", "heshtsad", "nehsad"]
    var liaison = " o "
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["sefr", "yek", "do", "se", "chahâr", "panj", "shesh", "haft", "hasht", "noh", "dah", "yâzdah", "davâzdah","sizdah","chahârdah", "poonzdah", "shoonzdah", "hifdah","hijdah","noozdah"]
        feminin = masculin

        dizaines = ["bist", "si", "chehel", "panjâh", "shast", "haftâd", "hashtâd", "navad"]
        
        singrand = ["sad", "hezâr", "meyeleyon", "meyeleyâr"]     // meyeleyâr est inventé
        plugrand = singrand
        
        greatest = 999999999999
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
            return singrand[1] + " " + cdu

        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }
    
}

public class Farsi:Persan{     // non opérant et non utilisé
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["صفر", "یک", "دو", "три", "четири", "пет", "шест", "седем", "осем", "девет", "десет", "еднонадесет", "двенадесет", "тринадесет", "четиринадесет", "петнадесет", "шестнадесет", "седемнадесет", "осемнадесет", "деветнадесет"]
        feminin = masculin

        
        dizaines = ["двадесет", "тридесет", "четиридесет", "петдесет", "шестдесет", "седемдесет", "осемдесет", "деветдесет"]
        centaines = ["сто","двеста","триста", "четиристотин", "петстотин", "шестстотин", "седемстотин", "осемстотин", "деветстотин"]
        
        singrand = ["هزار", "میلیون" ,"صد"]
        plugrand = singrand
        
        liaison = " و "
    }
}

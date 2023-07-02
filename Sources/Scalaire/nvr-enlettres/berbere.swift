//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Tamazight:Litteral {
    
    var liaison = " n "
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["amya", "yan", "sin", "krad", "kkuz", "smmus", "sdis", "sa", "tam", "tza", "mraw", "yan d mraw", "sin d mraw", "krad d mraw", "kkuz d mraw", "smmous d mraw", "sdis d mraw", "sa d mraw", "tam d mraw", "tza d mraw"]
        feminin = ["amya", "yat", "snat", "kratt", "kkuzt", "smmust", "sdist", "sat", "tamt", "tzat", "mrawt", "yan d mrawt", "sin d mrawt", "krad d mrawt", "kouz d mrawt", "smmous d mrawt", "sdis d mrawt", "sa d mrawt", "tam d mrawt", "tza d mrawt"]

        dizaines = ["sin id mraw", "krad id mraw", "kouz id mraw", "smmous id mraw", "sdis id mraw", "sa id mraw", "tam id mraw", "tza id mraw"]
        
        singrand = ["timidi", "ifḍ", "mlyun", "mlyard", "blyun"]
        plugrand = ["timad", "afḍan", "mlyunad", "mlyardan", "blyunad"]
        
        greatest = 999999999999999
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
                return feminin[cent] + plugrand[0]
            } else {
                return feminin[cent] + plugrand[0] + du
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
            return construct(mil) + liaison + plugrand[1] + cdu
        }
    }
    
}

public class Tifinagh:Tamazight {
    
    public override init(_ value: Int) {
        super.init(value)
        
        liaison = " ⵏ "
        masculin = ["ⴰⵎⵢⴰ", "ⵢⴰⵏ", "ⵙⵉⵏ", "ⴽⵕⴰⴹ", "ⴽⴽⵓⵣ", "ⵙⵎⵎⵓⵙ", "ⵚⴹⵉⵚ", "ⵙⴰ", "ⵜⴰⵎ", "ⵜⵥⴰ", "ⵎⵔⴰⵡ", "ⵢⴰⵏ ⴷ ⵎⵔⴰⵡ", "ⵙⵉⵏ ⴷ ⵎⵔⴰⵡ", "ⴽⵕⴰⴹ ⴷ ⵎⵔⴰⵡ", "ⴽⴽⵓⵣ ⴷ ⵎⵔⴰⵡ", "ⵙⵎⵎⵓⵙ ⴷ ⵎⵔⴰⵡ", "ⵚⴹⵉⵚ ⴷ ⵎⵔⴰⵡ", "ⵙⴰ ⴷ ⵎⵔⴰⵡ", "ⵜⴰⵎ ⴷ ⵎⵔⴰⵡ", "ⵜⵥⴰ ⴷ ⵎⵔⴰⵡ"]
        feminin = ["ⴰⵎⵢⴰ", "ⵢⴰⵜ", "ⵙⵏⴰⵜ", "ⴽⵕⴰⵟⵜ", "ⴽⴽⵓⵣⵜ", "ⵙⵎⵎⵓⵙⵜ", "ⵚⴹⵉⵚⵜ", "ⵙⴰⵜ", "ⵜⴰⵎⵜ", "ⵜⵥⴰⵜ", "ⵎⵔⴰⵡⵜ", "ⵢⴰⵏ ⴷ ⵎⵔⴰⵡⵜ", "ⵙⵉⵏ ⴷ ⵎⵔⴰⵡⵜ", "ⴽⵕⴰⴹ ⴷ ⵎⵔⴰⵡⵜ", "ⴽⴽⵓⵣ ⴷ ⵎⵔⴰⵡⵜ", "ⵙⵎⵎⵓⵙ ⴷ ⵎⵔⴰⵡⵜ", "ⵚⴹⵉⵚ ⴷ ⵎⵔⴰⵡⵜ", "ⵙⴰ ⴷ ⵎⵔⴰⵡⵜ", "ⵜⴰⵎ ⴷ ⵎⵔⴰⵡⵜ", "ⵜⵥⴰ ⴷ ⵎⵔⴰⵡⵜ"]

        dizaines = ["ⵢⴰⵏ ⵉⴷ ⵎⵔⴰⵡ", "ⵙⵉⵏ ⵉⴷ ⵎⵔⴰⵡ", "ⴽⵕⴰⴹ ⵉⴷ ⵎⵔⴰⵡ", "ⴽⴽⵓⵣ ⵉⴷ ⵎⵔⴰⵡ", "ⵙⵎⵎⵓⵙ ⵉⴷ ⵎⵔⴰⵡ", "ⵚⴹⵉⵚ ⵉⴷ ⵎⵔⴰⵡ", "ⵙⴰ ⵉⴷ ⵎⵔⴰⵡ", "ⵜⴰⵎ ⵉⴷ ⵎⵔⴰⵡ", "ⵜⵥⴰ ⵉⴷ ⵎⵔⴰⵡ"]
        
        singrand = ["ⵜⵉⵎⵉⴹⵉ", "ⵉⴼⴹ", "ⵎⵍⵢⵓⵏ", "ⵎⵍⵢⵔⴰⴹ", "ⴱⵍⵢⵓⵏ"]
        plugrand = ["ⵜⵉⵎⴰⴹ", "ⴰⴼⴹⴰⵏ", "ⵎⵍⵢⵓⴰⴹ", "ⵎⵍⵢⵔⴰⴹⴰⵏ", "ⴱⵍⵢⵓⴰⴹ"]
        
    }
}

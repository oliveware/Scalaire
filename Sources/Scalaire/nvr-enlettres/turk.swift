//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Turc:Litteral {
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["sıfır", "bir", "iki", "üç", "dört", "beş", "altı", "yedi", "sekiz", "dokuz", "on", "on bir", "on iki", "on üç", "on dört", "on beş", "on altı", "on yedi", "on sekiz", "on dokuz"]
        feminin = masculin

        dizaines = ["yirmi", "otuz", "kırk", "elli", "altmış", "yetmiş", "seksen", "doksan"]
        
        singrand = ["yüz", "bin", "milyon", "milyar", "trilyon"]
        plugrand = singrand
        
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
            return singrand[0] + " " + du
        default:
            if n%100 == 0 {
                return masculin[cent] + " " + singrand[0]
            } else {
                return masculin[cent] + " " + singrand[0] + " " + du
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
            if mil > 9 && mil < 99 {
                let umil = mil%10 == 0 ? "" : masculin[n%10]
                let dizaine = ((mil-mil%10)/10)%10
                if dizaine == 1 {
                    return masculin[10] + umil + " " + singrand[1] + " " + cdu
                } else {
                    return dizaines[dizaine-2] + umil + " " + singrand[1] + " " + cdu
                }
            } else {
                return construct(mil) + " " + singrand[1] + " " + cdu
            }
        }
    }
    
}

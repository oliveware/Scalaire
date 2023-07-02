//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Polski:Litteral {
    
    let centaines = ["sto", "dwieście", "trzysta", "czterysta", "pięćset", "sześćset", "siedemset", "osiemset", "dziewięćset"]
    let liaison = " "
    
    
    public override init(_ value: Int) {
        super.init(value)
            masculin = ["zero", "jeden", "dwa", "trzy", "cztery", "pięć", "sześć", "siedem", "osiem", "dziewięć", "dziesięć", "jedenaście", "dwanaście", "trzynaście", "czterynaście", "piętnaście", "sześnaście", "siedemnaście", "osiemnaście", "dziewiętnaście"]
            feminin = masculin
            dizaines = ["dwadzieścia", "trzydzieści", "czterdzieści", "pięćdziesiąt", "sześćdziesiąt", "siedemdziesiąt", "osiemdziesiąt", "dziewięćdziesiąt"]
        singrand = ["tysiąc", "milion", "miliard", "bilion", "biliard", "trillón", "tryliard", "kwadrylion"]
        plugrand = singrand
        
        greatest = 1000000 * 1000000 * 1000000 - 1
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
     
        switch cent {
        case 0:
            return n%100 == 0 ? "" : dizunit(n, m)
        case 1:
            if n%100 == 0 {
                return centaines[0]
            } else {
                return centaines[0] + " " + dizunit(n, m)
            }
            
        default:
            if n%100 == 0 {
                return centaines[cent-1]
            } else {
                return centaines[cent-1] + " " + dizunit(n, m)
            }
        }
    }
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        let plumil = ["tysiące", "tysięcy"]      // différents pluriels de mille
        
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return singrand[0] + " " + cdu
        case 2,3,4:
            return construct(mil) + " " + plumil[0] + " " + cdu
        default:
            return construct(mil) + " " + plumil[1] + " " + cdu
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
            return feminin[2] + " " + singrand[1] + " " + mil(n%1000000)
        default :
             let reste = milmil%10
             if reste == 1 || reste == 2 {
                 return feminin[reste] + " " + singrand[1] + " " + mil(n%1000000)
             } else {
                 return construct(milmil) + " " + singrand[1] + " " + mil(n%1000000)
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
            return feminin[2] + " " + singrand[2] + " " + million(n%1000000000)
        default:
            let reste = milmilmil%10
            if reste == 1 || reste == 2 {
                return feminin[reste] + " " + singrand[2] + " " + million(n%1000000000)
            } else {
                return construct(milmilmil) + " " + singrand[2] + " " + million(n%1000000000)
            }
        }
    }
}

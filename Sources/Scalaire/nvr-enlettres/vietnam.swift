//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Viet:Litteral{
        
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["số không", "môt", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín", "mười"]
        
        singrand = ["trăm", "ngàn", "triệu", "tỷ"]

    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
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
            switch un {
            case 0:
                return masculin[10]
            default:
                return masculin[10] + " " + masculin[un]
            }
        default:
            if un == 0 {
                return masculin[dizaine] + " " + masculin[10]
            } else {
                return masculin[dizaine] + " " + masculin[10] + " " + masculin[un]
            }
        }
    }
    
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
     
        switch cent {
        case 0:
            return n%100 == 0 ? "" : " " + dizunit(n, m)
        case 1:
            if n%100 == 0 {
                return singrand[0]
            } else {
                return singrand[0] + " " + dizunit(n, m)
            }
            
        default:
            if n%100 == 0 {
                return masculin[cent] + " " + singrand[0]
            } else {
                return masculin[cent] + " " + singrand[0] + " " + dizunit(n, m)
            }
        }
    }
    
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return cdu
        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }
    
    public override func million(_ n: Int)->String{
        let pion = powers[2]
        let milmil = ((n-n%pion)/pion)%pion
        
        switch milmil {
        case 0:
            return n%powers[0] == 0 ? "" : mil(n%pion)
        default:
            return construct(milmil) + " " + singrand[2] + " " + mil(n%pion)
        }
    }
    
   public override func milliard(_ n: Int)->String{
        let piard = powers[3]
        let milmilmil = ((n-n%piard)/piard)%piard
        
        switch milmilmil {
        case 0:
            return million(n%piard)
        default:
            return construct(milmilmil) + " " + singrand[3] + " " + million(n%piard)
        }
    }
}

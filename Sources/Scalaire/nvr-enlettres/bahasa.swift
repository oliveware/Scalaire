//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Bahasa:Litteral{
    
    //  na pas utiliser directement cette classe
    
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
            case 1:
                return "sebelas"
            default:
                return masculin[un] + " belas"
            }
        default:
            if un == 0 {
                return masculin[dizaine] + " puluh"
            } else {
                return masculin[dizaine] + " puluh " + masculin[un]
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
                return "seratus"
            } else {
                return "seratus " + dizunit(n, m)
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
            return centdizunit(n%1000)
        case 1:
            return "seribu " + cdu
            
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
        case 1:
            return "sejuta " + mil(n%pion)
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
        case 1:
            return "semilyar " + million(n%piard)
        default:
            return construct(milmilmil) + " " + singrand[3] + " " + million(n%piard)
        }
    }
}

public class Indonésien:Bahasa{
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["kosong", "satu", "dua", "tiga", "empat", "lima", "enam", "tujuh", "delapan", "sembilan", "sepuluh"]
        
        singrand = ["ratus", "ribu", "juta", "milyar"]

    }
}
public class Malais:Bahasa{
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["sifar", "satu", "dua", "tiga", "empat", "lima", "enam", "tujuh", "lapan", "sembilan", "sepuluh"]
        
        singrand = ["ratus", "ribu", "juta", "milyar"]

    }
}

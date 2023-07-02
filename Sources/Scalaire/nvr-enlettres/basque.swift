//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Basque:Litteral{
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["zero", "bat", "bi", "hiru", "lau", "bost", "sei", "zazpi", "zortzi", "bederatzi","hamar","hamaika","hamabi","hamahiru","hamalau", "hamabost", "hamasei", "hamazazpi","hemezortzi","hemeretzi"]
        feminin = masculin
        dizaines = ["hogei", "hogeita hamar", "berrogei", "berrogeita hamar", "hirurogei", "hirurogeita hamar", "laurogei", "laurogeita hamar"]
        singrand = ["ehun","mila","milioi","miliar"]
    }
    
    public override func dizunit(_ n : Int, _ m:Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return un == 0 ? "" : masculin[un]
        case 1:
            return masculin[10+un]
        case 3,5,7,9:
            return dizaines[dizaine-3] + "ta " + masculin[un+10]
        default:
            switch un {
            case 0:
                return dizaines[dizaine-2]
            default:
                return dizaines[dizaine-2] + "ta " + masculin[un]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m:Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let du = n%100 == 0 ? "" : " eta " + dizunit(n)
        switch cent {
        case 0:
            return dizunit(n)
        case 1:
            if n == 100 {
                return singrand[0]
            } else {
                return singrand[0] + du
            }
        case 2:
            if n == 200 {
                return "berr" + singrand[0]
            } else {
                return "berr" + singrand[0] + du
            }
        case 3:
            if n == 300 {
                return "hirur" + singrand[0]
            } else {
                return "hirur" + singrand[0] + du
            }
        default:
            if n%100 == 0 {
                return masculin[cent] + singrand[0]
            } else {
                return masculin[cent] + singrand[0]  + du
            }
        }
    }
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        let conj = n%1000 < 100 ? " eta " : ", "
        let cdu = n%1000 == 0 ? "" : conj + centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return singrand[1] + cdu

        default:
            return construct(mil) + " " + singrand[1] + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        let conj = n%1000000 < 100 ? " ta " : ", "
        let mcdu = n%1000000 == 0 ? "" : conj + mil(n%1000000)
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        default:
            return construct(milmil) + " " + singrand[2] + mcdu
        }
    }
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        let conj = n%1000000000 < 100 ? " ta " : ", "
        let mcdu = n%1000000000 == 0 ? "" : conj + million(n%1000000000)
        
        switch milmilmil {
         case 0:
             return million(n%1000000000)
         default:
            return construct(milmilmil) + " " + singrand[3] + mcdu
        }
    }
}

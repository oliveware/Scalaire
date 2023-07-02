//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation
// Numérations d'origine Maya en base 20

public class Maya:Litteral {
    
    public override init(_ value: Int) {
        super.init(value)
        powers = [20, 400, 8000, 160000, 3200000, 64000000, 1280000000, 25600000000]
        
        masculin = ["", "hun", "ca", "ox", "can", "ho", "uac", "uuc", "uaxac", "bolon", "lahun", "buluc", "lahca", "ox-lahun", "can-lahun", "ho-lahun", "uac-lahun", "uuc-lahun", "uaxac-lahun", "bolon-lahun"]
        feminin = masculin
        dizaines = ["kal", "ca kal", "ox kal", "can kal", "ho kal", "uac kal", "uuc kal", "uaxac kal", "bolon kal"]
    // inventé à partir du million
        singrand = ["bak", "pic", "calab"]
        plugrand = singrand
        
        greatest = (powers[7] * 20) - 1
    }
    // diz représente une vingtaine (base 20)
    override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let unite = n%base
        let vingtaine = ((n-unite)/base)%base
            
        switch vingtaine {
        case 0:
            return masculin[unite]
        case 1:
            switch unite {
            case 10:
                return "lahun ca kal"
            case 15:
                return "holhu ca kal"
            default:
                return masculin[unite] + " tu-kal"
            }
            case 19:
            if n < 400 {
                return masculin[unite] + " tu-y-" + masculin[2] + "-kal"
            } else {
                return masculin[unite] + " tu-y-"
            }
        default:
            return masculin[unite] + " tu-y-" + masculin[vingtaine+1] + "-kal"
        }
    }
    // faux  -> à corriger
    // ======================
    
    override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let pow = powers[1] // 400
        let dun = n%pow
        let quatrecent = ((n-dun)/pow)%base
        let du = dun == 0 ? "" : dizunit(dun)
     
        // supposé en dérivant dizunit
        switch quatrecent {
        case 0:
            return du
        case 1:
            switch dun%20 {
            case 10:
                return "lahun ca bak"
            case 15:
                return "holhu ca bak"
            default:
            return masculin[dun] + " tu-bak"
            }
        default:
            return masculin[dun] + " tu-y-" + masculin[quatrecent+1] + "-bak"
        }
    }
}

public class Mapuche:Litteral {
    
    public override init(_ value: Int) {
        super.init(value)
        powers = [20, 400, 8000, 160000, 3200000, 64000000, 1280000000, 25600000000]
        
        masculin = ["sero", "kiñe", "epu", "küla", "meli", "kechu", "kayu", "reqle", "pura", "aylla", "mari", "mari kiñe", "mari epu", "mari küla", "mari meli", "mari kechu", "mari kayu", "mari reqle", "mari pura", "mari aylla"]
        feminin = masculin
        dizaines = ["epu mari", "küla mari", "meli mari", "kechu mari", "kayu mari", "reqle mari", "pura mari", "aylla mari"]
    // inventé à partir du million
        singrand = ["pataka", "warangka", "miliünka", "miliarka", "biliünka", "biliarka"]
        plugrand = singrand
        
        greatest = (powers[7] * 20) - 1
    }
}

class Chol: Litteral{
    
    let racunit = ["", "jum", "cha'", "ux", "chän", "jo'", "wäc", "wuc", "waxä", "bolom", "lujum"]
    let racpow = ["p'ej", "c'al", "bajc'", "pic", "myon", "miard"]   // myon et miard sont inventés
    
    public override init(_ value: Int) {
        super.init(value)
        powers = [20, 400, 8000, 160000, 3200000, 64000000, 1280000000, 25600000000]
        
        masculin = []
        for i in 1...10 {
            masculin.append(racunit[i])
        }
        masculin.append("junlujum")    // exception
        masculin.append("lajchäm")      // exception
        for i in 3...9 {
            masculin.append(racunit[i] + "lujum") // ["uxlujum", "chänlujum", "jo'lujum", "wuclujum", "waxälujum", "bolonlujum"]
        }
        feminin = masculin
        
        // vingtaines
        dizaines = ["junk'al"]      // exception
        for i in 1...18 {
            dizaines.append(masculin[i] + racpow[1])
        }
        singrand = []
        
        greatest = (powers[4] * 20) - 1
    }
    
    override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let unite = n%base
        if unite == 0 {
            return ""
        } else {
            let dizaine = ((n-unite)/base)%base
            switch dizaine {
            case 0:
                return masculin[unite-1] + racpow[0]
            default:
                return masculin[unite-1] + racpow[0] + " i " + dizaines[dizaine-1]
            }
        }
    }
    override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let pow = powers[1] // 400
        let cent = ((n-n%pow)/pow)%base
        let du = n%pow == 0 ? "" : dizunit(n%pow) + " i "
     
        switch cent {
        case 0:
            return dizunit(n)
        default:
            return du + racunit[cent] + racpow[2]
        }
    }
    
    override func mil(_ n:Int)-> String {
        let pow = powers[2] // 8 000
        let mil = ((n-n%pow)/pow)%base
        let cdu = n%pow == 0 ? "" : centdizunit(n%pow) + " i "
        
        switch mil {
        case 0:
            return centdizunit(n%pow)
        default:
            return cdu + racunit[mil] + racpow[3]
        }
    }
    override func million(_ n:Int)-> String {
        let pow = powers[3] // 160 000
        let milmil = ((n-n%pow)/pow)%base
        let mcdu = n%pow == 0 ? "" : mil(n%pow) + " i "
        
        switch milmil {
        case 0:
            return mil(n%pow)
        default:
            return mcdu + racunit[milmil] + racpow[4]
        }
    }
    override func milliard(_ n:Int)-> String {
        let pow = powers[4] // 3 200 000
        let milmilmil = ((n-n%pow)/pow)%base
        let mmcdu = n%pow == 0 ? "" : million(n%pow) + " i "
        
        switch milmilmil {
        case 0:
            return million(n%pow)
        default:
            return mmcdu + racunit[milmilmil] + racpow[5]
        }
    }
}

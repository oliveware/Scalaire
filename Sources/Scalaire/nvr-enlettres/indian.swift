//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Hindi:Litteral {
    var dizu : [[String]] = []
   
    
    public override init(_ value: Int) {
        super.init(value)
        // les chiffres sont groupés par paires
        powers = [100, 1000, 100000, 10000000, 1000000000,1000000000000]
        
        masculin = ["shoony", "ēk", "do", "teen", "chaār", "pānch", "chah", "saāt", "āth", "nau", "das",
                    "gyārah", "bārah", "tērah", "chaudah", "pandrah", "solah", "satrah", "atthārah", "unnis",
                    
            ]
        feminin = masculin

        dizaines = ["bees", "tīs", "chālīs", "pacās", "sāth", "sattar", "assī", "nabbē"]
        
        dizu.append(["ikkīs", "bāīs", "tēīs", "chaubīs", "pachchīs", "chhabbīs", "sattāīs", "aṭṭhāīs", "unatīs"])
        dizu.append(["ikatīs", "battīs", "taiṃtīs", "chauṃtīs", "paiṃtīs", "chattīs", "saiṃtīs", "aṛatīs", "unatālīs"])
        dizu.append(["ikatālis", "biyālis", "taiṃtālīs", "chauṃtālīs", "paiṃtālīs", "chiyālīs", "saiṃtālīs", "aṛatālīs", "uncās"])
        dizu.append(["ikyāvan", "bāvan", "tirēpan", "chauvan", "pachapan", "chappan", "sattāvan", "aṭṭhāvan", "unasaṭh"])
        dizu.append(["ikasaṭh", "bāsaṭh", "tirasaṭh", "chauṃsaṭh", "paiṃsaṭh", "chiyāsaṭh", "sarasaṭh", "aṛasaṭh", "unahattar"])
        dizu.append(["ikahattar", "bahattar", "tihattar", "chauhattar", "pachahattar", "chihattar", "satahattar", "aṭhahattar", "unāsī"])
        dizu.append(["ikyāsī", "bayāsī", "tirāsī", "chaurāsī", "pachāsī", "chiyāsī", "sattāsī", "aṭhāsī", "navāsī"])
        dizu.append(["ikyānavē", "bānavē", "tirānavē", "chaurānavē", "pachānavē", "chiyānavē", "sattānavē", "aṭṭhānavē", "ninyānavē"])
        
        singrand = ["sau", "hazār", "lākh", "karod", "arab", "kharab"]
        plugrand = singrand
        
        greatest = 999999999999999
    }
    
    public  override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return masculin[un]
        case 1:
            return masculin[10+un]
        default:
            if un == 0 { return dizaines[dizaine-2] } else { return dizu[dizaine-2][un-1] }
        }
    }
    public  override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let du = n%100 == 0 ? "" : dizunit(n%100, m)
        
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
    public  override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return masculin[1] + " " + singrand[1] + " " + cdu

        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }
    
}

public class Devanagari:Hindi {
    
    public override init(_ value: Int) {
        super.init(value)
        
        masculin = ["शून्य", "एक", "दो", "तीन", "चार", "पाँच", "छह", "सात", "आठ", "नौ", "दस", "ग्यारह", "बारह", "तेरह", "चौदह", "पंद्रह", "सोलह", "सत्रह", "अट्ठारह", "उन्नीस"]
        feminin = masculin
        
        dizu = []
        dizu.append(["इक्कीस", "बाईस", "तेईस", "चौबिस", "पच्चीस", "छब्बीस", "सत्ताईस", "अट्ठाईस", "उनतीस"])
        dizu.append(["इकतीस", "बत्तीस", "तैंतीस", "चौंतीस", "पैंतीस", "छत्तीस", "सैंतीस", "अड़तीस", "उनतालीस"])
        dizu.append(["इकतालीस", "बयालीस", "तैंतालीस", "चौंतालीस", "पैंतालीस", "छयालीस", "सैंतालीस", "अड़तालीस", "उनचास"])
        dizu.append(["इक्यावन", "बावन", "तिरेपन", "चौवन", "पचपन", "छप्पन", "सत्तावन", "अट्ठावन", "उनसठ"])
        dizu.append(["इकसठ", "बासठ", "तिरेसठ", "चौंसठ", "पैंसठ", "छयासठ", "सरसठ", "अड़सठ", "उनहत्तर"])
        dizu.append(["इकहत्तर", "बहत्तर", "तिहत्तर", "चौहत्तर", "पचहत्तर", "छिहत्तर", "सतहत्तर", "अठहत्तर", "उन्यासी"])
        dizu.append(["इक्यासी", "बयासी", "तिरासी", "चौरासी", "पचासी", "छियासी", "सत्तासी", "अठासी", "नवासी"])
        dizu.append(["इक्यानवे", "बानवे", "तिरानवे", "चौरानवे", "पचानवे", "छियानवे", "सत्तानवे", "अट्ठानवे", "निन्यानवे"])
      
        dizaines = ["बीस", "तीस", "चालीस", "पचास", "साठ", "सत्तर", "अस्सी", "नब्बे"]
        
        singrand = ["सौ", "हज़ार", "लाख", "करोड़", "अरब"]
        plugrand = singrand
        
        greatest = 999999999999999
    }
}


public class Rohingya:Litteral {
    
    public override init(_ value: Int) {
        super.init(value)
       
       // les chiffres sont groupés par paires
        powers = [100, 1000, 100000, 10000000, 1000000000,1000000000000]
        
       masculin = ["sifir", "ek", "dui", "tin", "sair", "fañs", "só", "háñt", "añctho", "no", "doc",
                    "egaro", "baró", "teró", "soiddó", "fundóroh", "cúlloh", "háñtaroh", "añçároh", "unnúic",
                    
            ]
        feminin = masculin

        dizaines = ["kuri", "tiric", "calic", "fonjaic", "áit", "óttoir", "aci", "nobboi"]
        
        singrand = ["cót", "házar", "lák", "kuti", "kurul"]
        plugrand = singrand
        
        greatest = 999999999999999
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return masculin[un]
        case 1:
            return masculin[10+un]
        default:
            if un == 0 {
                return dizaines[dizaine-2]
                
            } else {
                return dizaines[dizaine-2] + " " + masculin[un]
                
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
            if n%100 == 0 {
                return masculin[cent] + "-" + singrand[0]
            } else {
                return "ekcó " + du
            }
        default:
            if n%100 == 0 {
                return masculin[cent] + "-" + singrand[0]
            } else {
                return masculin[cent] + " có " + du
            }
        }
    }
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)

        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }
    
}

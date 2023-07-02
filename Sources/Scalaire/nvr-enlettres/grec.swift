//
//  grec.swift
//  
//
//  Created by Herve Crespel on 23/08/2022.
//

import Foundation

public class Grec: Ellenika{
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["midén", "éna", "dýo", "tria'", "téssera", "pénte", "éxi", "eptá", "októ", "néos", "déka", "énteka", "dódeka", "dekatria'", "dekatéssera", "dekapénte", "dekaéxi", "dekaeptá", "dekaochtó", "dekaennéa"]
        feminin = masculin

        dizaines = ["eíkosi", "triánta", "saránta", "penínta", "exínta", "evdomínta", "ogdónta", "enenínta"]
        
        centaines = ["ekató", "diakósia", "triakósia", "tetrakósia", "pentakósia", "exakósia", "eftakósia", "ochtakósia", "enniakósia"]
        
        singrand = ["chília", "ekatommýrio", "disekatommýrio", "trisekatommýrio"]
        plugrand = ["chília", "ekatommýria", "disekatommýria", "trisekatommýria"]
    }
    
}

public class Ellenika: Litteral{
    
    var centaines = ["εκατό", "διακόσια", "τριακόσια", "τετρακόσια", "πεντακόσια", "εξακόσια", "εφτακόσια", "οχτακόσια", "εννιακόσια"]
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["μηδέν", "ένα", "δύο", "τρία", "τέσσερα", "πέντε", "έξι", "επτά", "οκτώ", "νέος", "δέκα", "έντεκα", "δώδεκα", "δεκατρία", "δεκατέσσερα", "δεκαπέντε", "δεκαέξι", "δεκαεπτά", "δεκαοχτώ", "δεκαεννέα"]
        feminin = masculin
        
        dizaines = ["είκοσι", "τριάντα", "σαράντα", "πενήντα", "εξήντα", "εβδομήντα", "ογδόντα", "ενενήντα"]

        
        singrand = ["χίλια","εκατομμύριο","δισεκατομμύριο", "τρισεκατομμύριο"]
        plugrand = ["χιλιάδες","εκατομμύρια","δισεκατομμύρια", "τρισεκατομμύρια"]
        
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
            
        default:
            if n%100 == 0 {
                return centaines[cent-1]
            } else {
                return centaines[cent-1] + " " + du
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
}


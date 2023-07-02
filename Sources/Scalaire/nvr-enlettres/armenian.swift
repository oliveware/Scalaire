//
//  armenian.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Armenien: Hayeren{
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["zro", "mek", "erkow", "erek'", "čors", "hing", "vec'", "yot'", "owt'", "inë", "tas", "tasnmek", "tasnerkow", "tasnerek'", "tasnčors", "tasnhing", "tasnvec'", "tasnyot'", "tasnowt'", "tasninë"]
        feminin = masculin

        dizaines = ["k'san", "eresown'", "k'arasown", "hisown", "vat'sown", "yot'anasown", "owt'sown", "innsown"]
        
        singrand = ["haryowr", "hazar", "milion", "miliard", "trilion"]
        plugrand = singrand
    }
    
}

public class Hayeren: Litteral{     // non opérant et non utilisé
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["zero", "մեկ", "երկու", "երեք", "չորս", "հինգ", "վեց", "յոթ", "ութ", "ինը", "տաս", "տասնմեկ", "տասներկու ", "տասներեք", "տասնչորս", "տասնհինգ", "տասնվեց", "տասնյոթ", "տասնութ", "տասնինը"]
        feminin = masculin
        
        dizaines = ["քսան", "երեսուն", "քառասուն", "հիսուն", "վաթսուն", "յոթանասուն ", "ութսուն", "իննսուն"]
        
        singrand = ["հարյուր","հազար","միլիոն","միլիարդ", "տրիլիոն"]
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
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }
}

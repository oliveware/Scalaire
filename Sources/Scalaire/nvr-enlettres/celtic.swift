//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Breton: Litteral{
    
    public override init(_ value: Int) {
        super.init(value)

        masculin = ["mann", "unan", "daou", "tri", "pevar", "pemp", "c'hwec'h", "seizh", "eizh", "nav","dek","unnek","daouzek","trizek","pevarzek", "pemzek", "c'hwezek", "seitek","triwec'h","naontek"]
        feminin = masculin
        feminin[2] = "div"
        feminin[3] = "teir"
        feminin[4] = "peder"
        
        dizaines = ["ugent", "tregont", "daou-ugent", "hanter-kant", "tri-ugent", "dek ha tri-ugent", "pevar-ugent", "dek ha pevar-ugent"]
        singrand = ["kant","mil","million","milliard"]
    }
    
    func unit(_ n : Int, _ prefix:String, _ m: Bool = true)-> String {
        if n == 0 {
            return ""
        } else {
            return( m ? masculin[n] : feminin[n]) + " " + prefix
        }
    }
    
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let unite = n%10
        let dizaine = ((n-unite)/10)%10
        switch dizaine {
        case 0:
            return unit(unite, "")
        case 1:
            return unit(10+unite, "")
        case 2:
            return unit(unite,"warn ") + "ugent"
        case 4,6,8:
            return unit(unite,"ha ") + masculin[dizaine/2] + "-ugent"
        case 5:
            return unit(unite,"ha ") + "hanter-kant"
        case 7:
            return unit(unite,"ha ") + "dek ha tri-ugent"
        case 9:
            return unit(unite,"ha ") + "dek ha pevar-ugent"
        default: // 3
            return unit(unite,"ha ") + dizaines[1]
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let du = n%100 == 0 ? "" : dizunit(n%100)
        
        switch cent {
        case 0:
            return dizunit(n)
        case 1:
            return "kant " + du
        case 2,3,4,9:
            return masculin[cent] + " c'hant " + du
        default:
            return masculin[cent] + " kant " + du
        }
    }
    
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return "mil " + cdu
        case 2:
            return "daou vil " + cdu
        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        case 1:
            return "ur " + singrand[2] + " " + mil(n%1000000)
        default:
            return construct(milmil) + " " + singrand[2] + " " + mil(n%1000000)
        }
    }
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
         case 0:
             return million(n%1000000000)
         case 1:
             return "ur " + singrand[3] + " " + million(n%1000000000)
         default:
             return construct(milmilmil) + " " + singrand[3] + " " + million(n%1000000000)
        }
    }
}


class Irish: Litteral{
    // gaelic irlandais moderne
    public override init(_ value: Int) {
        super.init(value)
            
        masculin = ["neoni", "aon", "dó", "trì", "ceathair", "cúig", "sé", "seacht", "ocht", "naoi","deich","aon déag"," dó dhéag"," trì déag","ceathair déag", "cúig déag", "sé déag", "seacht déag","ocht déag","naoi déag"]
        feminin = masculin
        
        dizaines = ["fich", "triocha", "ceathracha", "caoga", "seasca", "seachtó", "ochtó", "nócha"]
        singrand = ["céad","míle","milliún"]   // milliard n'existe pas
        
        moins = "lúide"
    }
    
    func unit(_ n : Int, _ prefix:String)-> String {
        if n == 0 {
            return ""
        } else {
            return masculin[n] + " " + prefix + " "
        }
    }
    
    override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let unite = n%10
        let dizaine = ((n-unite)/10)%10
        switch dizaine {
        case 0:
            return masculin[unite]
        case 1:
            return masculin[unite+10]
        default:
            let liaison = " 's a "
            switch unite {
            case 0:
                return dizaines[dizaine-2]
            case 1:
                return dizaines[dizaine-2] + liaison + "haon"
            default:
                return dizaines[dizaine-2] + liaison + masculin[unite]
            }
        }
    }
    override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let du = n%100 == 0 ? "" : dizunit(n%100)
     
        switch cent {
        case 0:
            return du
        case 1:
            return "céad " + du
        default:
            return masculin[cent] + " céad " + du
        }
    }
    
    override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return "mile " + cdu
        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }
    override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        case 1:
            return "aon " + singrand[2] + " " + mil(n%1000000)
        default:
            return construct(milmil) + " " + singrand[2] + " " + mil(n%1000000)
        }
    }
    override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
         case 0:
             return million(n%1000000000)
        case 1:
            return "mile " + million(n%1000000000)
        default:
            return construct(milmilmil) + " mile " + million(n%1000000000)
        }
    }
}



public class Scottish: Litteral{
    // gaelic écossais moderne
    public override init(_ value: Int) {
        super.init(value)

        masculin = ["neoni", "aon", "dhà", "trì", "ceithir", "còig", "sia", "seachd", "ochd", "naoi","deich","h-aon deug"," dhà dheug"," trì deug","ceithir deug", "còig deug", "sia deug", "seachd deug","ochd deug","naoi deug"]
        feminin = masculin
            
        dizaines = ["fichead", "trithead", "ceathread", "caogad", "seasgad", "seachdad", "ochdad", "naochad"]
        singrand = ["ceud","mile","millean","billean"]
        plugrand = singrand
    }
    
    func unit(_ n : Int, _ prefix:String)-> String {
        if n == 0 {
            return ""
        } else {
            return masculin[n] + " " + prefix + " "
        }
    }
    
    public override func dizunit(_ n : Int, _ m : Bool = true)-> String {
        let unite = n%10
        let dizaine = ((n-unite)/10)%10
        switch dizaine {
        case 0:
            return masculin[unite]
        case 1:
            return masculin[unite+10]
        default:
            var liaison = " 's a "
            if unite == 1 || unite == 8 {
                liaison += "h-"
            }
            let unit = unite == 0 ? "" : liaison + masculin[unite]
            return dizaines[dizaine-2] + unit
        }
    }
    public override func centdizunit(_ n : Int, _ m : Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        let du = n%100 == 0 ? "" : dizunit(n%100)
     
        switch cent {
        case 0:
            return du
        case 1:
            return "ceud " + du
        default:
            return masculin[cent] + " ceud " + du
        }
    }
    
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return "mile " + cdu
        case 2:
            return "dhà mhile " + cdu
        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }

}


public class Wales: Litteral{
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["sero", "un", "dau", "tri", "pedvar", "pump", "chwech", "saith", "wyth", "naw","deg","undeg un","undeg dau","undeg tri","undeg pedvar", "undeg pump", "undeg chwech", "undeg saith","undeg wyth","undeg naw"]
        feminin = masculin
            
        dizaines = ["daudeg", "trideg", "pedwardeg", "pumdeg", "chwedeg", "saithdeg", "wythdeg", "nawdeg"]
        
        singrand = ["cant", "mil", "miliwn", "biliwn"]
        plugrand = ["cant", "mil", "miliynau", "biliynau"]
        
        moins = "minws"
    }
    
    public override func dizunit(_ n : Int, _ m:Bool = true)-> String {
        let unite = n%10
        let dizaine = ((n-unite)/10)%10
        switch dizaine {
        case 0:
            return m ? masculin[unite] : feminin[unite]
        case 1:
            return m ? masculin[unite+10] : feminin[unite+10]
        default:
            let du = m ? masculin[unite] : feminin[unite]
            let unit = unite == 0 ? "" : " " + du
            return dizaines[dizaine-2] + unit
        }
    }
    public override func centdizunit(_ n : Int, _ m:Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
        
        let dizun = n%100
        
        var du : String
        switch dizun {
        case 0:
            du = ""
        case 1:
            du = " ac " + dizunit(n)
        case 2,3,4,5,6,7,8,9,10:
            du = " a "  + dizunit(n)
        default:
            du = " " + dizunit(n)
        }
     
        switch cent {
        case 0:
            return dizun == 0 ? "" : dizunit(n)
        case 1:
            return "cant" + du
        case 2:
            return "dau gant" + du
        case 3:
            return "tri chant" + du
        default:
            return masculin[cent] + " cant" + du
        }
    }
    
    public override func mil(_ n:Int)-> String {
        let mil = ((n-n%1000)/1000)%1000
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return "mil " + cdu
        case 2:
            return "dau vil " + cdu
        default:
            return construct(mil) + " " + singrand[1] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0:
            return mil(n%1000000)
        case 1:
            return singrand[2] + " " + mil(n%1000000)
        default:
            return construct(milmil) + " miliynau " + mil(n%1000000)
        }
    }
    public override func milliard(_ n:Int)-> String {
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
         case 0:
             return million(n%1000000000)
         case 1:
             return singrand[3] + " " + million(n%1000000000)
         default:
             return construct(milmilmil) + " biliynau " + million(n%1000000000)
        }
    }
}

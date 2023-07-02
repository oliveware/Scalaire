//
//  File.swift
//  
//
//  Created by Herve Crespel on 22/11/2021.
//

import Foundation

public class Srpski:Litteral {
    
    // centaines au masculin
    var centaines = ["sto", "dvesta", "trista", "četiristo", "petsto", "šeststo", "sedamsto", "osamsto", "devetsto"]
    // centaines au féminin
    var femtaines = ["jedna stotina", "dve stotine", "tri stotine", "četiri stotine", "pet stotina", "šest stotina", "sedam stotina", "osam stotina", "devet stotina"]
    
    var liaison = " i "
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["nula", "jedan", "dva", "tri", "četiri", "pet", "šest", "sedam", "osam", "devet", "deset", "jedanaest", "dvanaest","trinaest", "četrnaest", "petnaest", "šesnaest", "sedamnaest", "osamnaest", "devetnaest"]
        feminin = masculin
        feminin[1] = "jedna"
        feminin[2] = "dve"
        neutre = masculin
        neutre[1] = "jedno"
        neutre[2] = "dva"
        
        dizaines = ["dvadeset", "trideset", "četrdeset", "pedeset", "šezdeset", "sedamdeset", "osamdeset", "devedeset"]
        
        singrand = ["hiljada", "milion", "milijarda"]
        plugrand = ["hiljade", "miliona", "milijarde"]
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
                return dizaines[dizaine-2] + liaison + du
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
                return singrand[0]
            } else {
                return singrand[0] + " " + dizunit(n, m)
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
        // mille est féminin
        let mil = ((n-n%1000)/1000)%1000
        
        let cdu = n%1000 == 0 ? "" : centdizunit(n%1000)
        
        switch mil {
        case 0:
            return centdizunit(n%1000)
        case 1:
            return singrand[0] + " " + cdu

        default:
            return construct(mil, false) + " " + plugrand[0] + " " + cdu
        }
    }
    public override func million(_ n:Int)-> String {
        // million est masculin
        let milmil = ((n-n%1000000)/1000000)%1000000
        
        switch milmil {
        case 0 :
            return mil(n%1000000)
        case 1:
            return feminin[1] + " " + singrand[1] + " " + mil(n%1000000)
        case 2:
            return feminin[2] + " " + plugrand[1] + " " + mil(n%1000000)
        default :
             let reste = milmil%10
             if reste == 1 || reste == 2 {
                 return feminin[reste] + " " + plugrand[1] + " " + mil(n%1000000)
             } else {
                 return construct(milmil) + " " + plugrand[1] + " " + mil(n%1000000)
             }
        }
    }
        
    public override func milliard(_ n:Int)-> String {
        // milliard est féminin
        let milmilmil = ((n-n%1000000000)/1000000000)%1000000000
        
        switch milmilmil {
        case 0:
             return million(n%1000000000)
        case 1:
            return feminin[1] + " " + singrand[2] + " " + million(n%1000000000)
        case 2:
            return feminin[2] + " " + plugrand[2] + " " + million(n%1000000000)
        default:
            let reste = milmilmil%10
            if reste == 1 || reste == 2 {
                return feminin[reste] + " " + plugrand[2] + " " + million(n%1000000000)
            } else {
                return construct(milmilmil, false) + " " + plugrand[2] + " " + million(n%1000000000)
            }
        }
    }
}

public class SerbeCyrillic:Srpski{
    
    public override init(_ value: Int) {
        super.init(value)
        masculin = ["нула", "један", "двa", "три", "четири", "пет", "шест", "седaм", "осaм", "девет", "десет", "једанaесет", "двaнaесет", "тринаесет", "четирнаесет", "петнаесет", "шестнаесет", "седaмнаесет", "осaмнаесет", "деветнаесет"]
        feminin = masculin
        feminin[1] = "једна"
        feminin[2] = "двe"
        neutre = masculin
        neutre[1] = "једно"
        neutre[2] = "двa"
        
        dizaines = ["двадесет", "тридесет", "четрдесет", "педесет", "шездесет", "седaмдесет", "осaмдесет", "деведесет"]
        
        centaines = ["сто","двеста","триста", "четиристотин", "петстотин", "шестстотин", "седемстотин", "осемстотин", "деветстотин"]
        femtaines = ["један стотина", "двe стотинe", "три стотинe", "четири стотинe", "пет стотина", "шест стотина", "седaм стотина", "осaм стотина", "девет стотина"]
        
        plugrand = ["хиљада", "милиона", "милиарда"]
        singrand = ["хиљада","милион", "милијарда", "билион" ]
        
        liaison = " и "
    }
}

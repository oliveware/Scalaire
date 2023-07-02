//
//  File.swift
//  
//
//  Created by Herve Crespel on 19/11/2021.
//

import Foundation

public var parle = true

public class Litteral: Construct {
    // les nombres de zéro à 19
    // beaucoup de langues ont un féminin pour les petits nombres
    // tifinagh-tamazight a un féminin de 1 à 19
    var feminin: [String] = []
    var masculin: [String] = []
    // quelques langues ont un neutre. Il est défini dans la classe correspondante
    var neutre: [String] = []
    var genre: Genre = .m
    
    var moins: String = "(-)"
    
    // la première dizaine est définie
    var dizaines: [String] = []
    var singrand: [String] = []
    var plugrand: [String] = []
    
    var greatest = 1000000 * 1000000
    
    private var value: Int = 0
    
    var base: Int = 10
    
    var powers = [100, 1000, 1000000, 1000000000, 1000000000000, 1000000000000000, 1000000000000000000]
    
   /* public init(_ n : Int, _ base:Int = 10) {
        self.base = base
        value = n
    }*/
    
    public init(_ v: Int) {
        value = v
    }
    
    func setgenre(_ g:Genre){
        genre = g
    }
    
    /*func makepowers() {
        var power = base
        powers = [base]
        for _ in 1...6 {
            power = power * base
            powers.append(power)
        }
    }*/
        
    public func lit()->String{
        var texte = ""
        if value == 0 {
            return masculin[0]
        } else {
            let m = genre == .m
            if value < 0 {
                texte = moins + " " + construct(-value, m)
            } else {
                texte = construct(value, m)
            }
            
            return texte
        }
    }
    
    func construct(_ n: Int, _ m: Bool = true)->String {
        
        if n < powers[0] {
            return dizunit(n, m)
        } else {
            if n < powers[1] {
                return centdizunit(n, m)
            } else {
                if n < powers[2] {
                    return mil(n)
                } else {
                    if n < powers[3] {
                        return million(n)
                    } else {
                        if n < powers[4] {
                            return milliard(n)
                        } else {
                            if n < powers[5] {
                                return billion(n)
                            } else {
                                if powers.count < 7 {
                                    return String(n)
                                } else {
                                    if n < powers[6] {
                                        return billiard(n)
                                    } else {
                                        return String(n)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func dizunit(_ n: Int, _ m : Bool = true)->String{
        let un = n%10
        let dizaine = ((n-un)/10)%10
        switch dizaine {
        case 0:
            return m ? masculin[un] : feminin[un]
        case 1:
            return m ? masculin[10+un] : feminin[10+un]
        
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
    func centdizunit(_ n: Int, _ m : Bool = true)->String{
        let pent = powers[0]
        let cent = ((n-n%pent)/pent)%pent
        let du = n%pent == 0 ? "" : dizunit(n%pent)
        switch cent {
        case 0:
            return du
        case 1:
            return singrand[0] + " " + du
        default:
            return masculin[cent] + " " + plugrand[0] + " " + du
        }
    }
    func mil(_ n: Int)->String{
        let pil = powers[1]
        let mil = ((n-n%pil)/pil)%pil
        
        switch mil {
        case 0:
            return n%powers[0] == 0 ? "" : centdizunit(n%pil)
        case 1:
            return singrand[1] + " " + centdizunit(n%pil)
        default:
            return construct(mil) + " " + plugrand[1] + " " + centdizunit(n%pil)
        }
    }
    func million(_ n: Int)->String{
        let pion = powers[2]
        let milmil = ((n-n%pion)/pion)%pion
        
        switch milmil {
        case 0:
            return n%powers[0] == 0 ? "" : mil(n%pion)
        case 1:
            return masculin[1] + " " + singrand[2] + " " + mil(n%pion)
        default:
            return construct(milmil) + " " + plugrand[2] + " " + mil(n%pion)
        }
    }
    func milliard(_ n: Int)->String{
        let piard = powers[3]
        let milmilmil = ((n-n%piard)/piard)%piard
        
        switch milmilmil {
        case 0:
            return million(n%piard)
        case 1:
            return masculin[1] + " " + singrand[3] + " " + million(n%piard)
        default:
            return construct(milmilmil) + " " + plugrand[3] + " " + million(n%piard)
        }
    }
    func billion(_ n: Int)->String{
        if n > greatest { return String(n)}
        
        let biop = powers[4]
        let bil = ((n-n%biop)/biop)%biop
        
        switch bil {
        case 0:
            return milliard(n%biop)
        case 1:
            return masculin[1] + " " + singrand[4] + " " + milliard(n%biop)
        default:
            return construct(bil) + " " + plugrand[4] + " " + milliard(n%biop)
        }
    }
    func billiard(_ n: Int)->String{
        if n > greatest { return String(n)}
        
        let biarp = powers[5]
        let tril = ((n-n%biarp)/biarp)%biarp
        
        switch tril {
        case 0:
            return billion(n%biarp)
        case 1:
            return masculin[1] + " " + singrand[5] + " " + billion(n%biarp)
        default:
            return construct(tril) + " " + plugrand[5] + " " + billion(n%biarp)
        }
    }
    
   public func enlettres(_ ecriture : Ecriture) -> String {
       
       let g10 = value
       
        switch ecriture {
        case .fr:
            return Francais(g10).lit()
        case .elg:
            return Ellenika(g10).lit()
        case .el:
            return Grec(g10).lit()
        case .en:
            return English(g10).lit()
        case .de:
            return Deutsch(g10).lit()
        case .it:
            return Italiano(g10).lit()
        case .sp:
            return Espagnol(g10).lit()
        case .nl, .fl:
            return Dutch(g10).lit()
        case .br:
            return Breton(g10).lit()
        case .scg:
            return Scottish(g10).lit()
        case .irg:
            return Irish(g10).lit()
        case .wag:
            return Wales(g10).lit()
        case .bibi:
            return Bibi(g10).lit()
        case .bro:
            return Brooding(g10).lit()
        case .latin:
            return Latin(g10).lit()
        case .bulc:
            return BulgareCyrillic(g10).lit()
        case .bg:
            return Bulgare(g10).lit()
        case .letton:
            return Letton(g10).lit()
        case .litua:
            return Lituanie(g10).lit()
        case .esto:
            return Estonie(g10).lit()
        case .dan:
            return Danois(g10).lit()
        case .isl:
            return Islande(g10).lit()
        case .af:
            return Afrikaans(g10).lit()
        case .bok:
            return Bokmal(g10).lit()
       case .kanji:
            return Kanji(value).lit()
        case .japa:
            return Kana(value).lit()
        case .japr:
            return Romaji(value).lit()
        case .rusc:
            return RusseCyrillic(g10).lit()
        case .rus:
            return Russe(g10).lit()
        case .bsq:
            return Basque(g10).lit()
        case .serb:
            return Srpski(g10).lit()
        case .srp:
            return SerbeCyrillic(g10).lit()
        case .pic:
            return Picard(g10).lit()
        case .far:
            return Persan(g10).lit()
        case .ar:
            return Arabe(g10).lit()
        case .mapu:
            return Mapuche(g10).lit()
        case .maya:
            return Maya(g10).lit()
        case .turc:
            return Turc(g10).lit()
        case .sue:
            return Suedois(g10).lit()
        case .tif:
            return Tifinagh(g10).lit()
        case .tmz:
            return Tamazight(g10).lit()
        case .hyr:
            return Armenien(g10).lit()
        case .hy:
            return Hayeren(g10).lit()
        case .amh:
            return Amish(g10).lit()
        case .chol:
            return Chol(g10).lit()
        case .als:
            return Alsacien(g10).lit()
        case .mal:
            return Malais(g10).lit()
        case .viet:
            return Viet(g10).lit()
        case .pin:
            return Pinyin(value).lit()
        case .twn:
            return Taiwan(value).lit()
        case .pol:
            return Polski(g10).lit()
        case .kor:
            return Hangeul(value).lit()
        case .khj:
            return Hanja(value).lit()
        case .hnd:
            return Hindi(g10).lit()
        case .rhg:
            return Rohingya(g10).lit()
        case .pt:
            return Portuguais(g10).lit()
        case .zh:
            return Hanzi(value).lit()
        case .np:
            return Devanagari(g10).lit()
        case .id:
            return Indonésien(g10).lit()
        case .uni:
            return Universal(value).lit()
        case .uk:
            return Ukraine(g10).lit()
        case .ukc:
            return UkraineCyrillic(g10).lit()
        }
    }

}

protocol Construct {
    func dizunit(_ n: Int, _ m : Bool)->String
    func centdizunit(_ n: Int, _ m : Bool)->String
    func mil(_ n: Int)->String
    func million(_ n: Int)->String
    func milliard(_ n: Int)->String
}

enum Genre : String {
    case f = "féminin"
    case m = "masculin"
    case n = "neutre"
}

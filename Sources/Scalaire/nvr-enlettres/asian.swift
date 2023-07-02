//
//  File.swift
//  
//
//  Created by Herve Crespel on 19/11/2021.
//

import Foundation

public class Kanji:Litteral {
    
    override public init(_ value: Int) {
        super.init(value)
        powers = [100, 1000, 10000, 100000000, 100000000000]
        
        masculin = ["〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]
        
        singrand = ["百", "千", "万", "億", "兆", "京", "垓"]
        
    }
    
    public override func construct(_ n : Int, _ m: Bool = true)->String {
        
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
                        return myriade(n)
                    } else {
                        if n < powers[4] {
                            return mymyriade(n)
                        } else {
                            return String(n)
                        }
                    }
                }
            }
        }
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
            if un == 0 {
                return masculin[10]
            } else {
                return masculin[10] + " " + masculin[un]
            }
        default:
            if un == 0 {
                return masculin[dizaine] + masculin[10]
            } else {
                return masculin[dizaine] + masculin[10] + " " + masculin[un]
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
                return masculin[cent] + singrand[0]
            } else {
                return masculin[cent] + singrand[0] + " " + dizunit(n, m)
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
            return construct(mil) + singrand[1] + " " + cdu
        }
    }
    public func myriade(_ n:Int)-> String {
        let dixmil = ((n-n%10000)/10000)%10000
        
        switch dixmil {
        case 0 :
            return mil(n%10000)
        case 1:
            return masculin[1] + singrand[2] + " " + mil(n%10000)
        default :
            return construct(dixmil) + singrand[2] + " " + mil(n%10000)
        }
    }
        
    public func mymyriade(_ n:Int)-> String {
        let centmillion = ((n-n%100000000)/100000000)%100000000
        
        switch centmillion {
        case 0:
             return myriade(n%100000000)
        case 1:
            return masculin[1] + singrand[3] + " " + myriade(n%100000000)
        default:
            return construct(centmillion) + singrand[3] + " " + myriade(n%100000000)
        }
    }
}

public class Pinyin: Hanzi{
    
    
    public override init(_ value:Int) {
        super.init(value)
        masculin = ["ling", "yī", "èr", "sān", "sì", "wǔ", "liù", "qī", "bā", "jiǔ", "shì"]
        
        paire = "liǎng"  // paire : 两
        
        singrand = ["bǎi", "qiān", "wàn", "yì", "gòu", "京", "垓"]
        
        moins = "jiân"

    }
}

public class Hanzi: Kanji {
    var paire = "两"
    
    public override init(_ value:Int) {
        super.init(value)
       
        masculin = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]
        
        
        singrand = ["百", "千", "万", "亿", "兆", "京", "垓"]
        // ancien wan 萬
        moins = "減"
        
    }
    public override func dizunit(_ n : Int, _ m: Bool = true)-> String {
        let un = n%10
        let dizaine = ((n-un)/10)%10
        
        switch dizaine {
        case 0:
            if un == 0 {
                return ""
            } else {
                let ling = n > 100 ? masculin[0] : ""
                return ling + masculin[un]
            }
        case 1:
            let yi = n < 20 ? "" : masculin[1]
            if un == 0 {
                return yi + masculin[10]
            } else {
                
                return yi + masculin[10] + " " + masculin[un]
            }
        default:
            if un == 0 {
                return masculin[dizaine] + masculin[10]
            } else {
                return masculin[dizaine] + masculin[10] + " " + masculin[un]
            }
        }
    }
    public override func centdizunit(_ n : Int, _ m: Bool = true)-> String {
        let cent = ((n-n%100)/100)%10
     
        switch cent {
        case 0:
            let ling = n%10 == 0 ? "" : masculin[0]
            return n%100 == 0 ? ling : dizunit(n, m)
        case 1:
            if n%100 == 0 {
                return masculin[1] + singrand[0]
            } else {
                return masculin[1] + singrand[0] + " " + dizunit(n, m)
            }
        case 2:
            return paire + singrand[0] + " " + dizunit(n, m)
            
        default:
            if n%100 == 0 {
                return masculin[cent] + singrand[0]
            } else {
                return masculin[cent] + singrand[0] + " " + dizunit(n, m)
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
            return masculin[1] + singrand[1] + " " + cdu
        case 2:
            return paire + singrand[1] + " " + cdu
        default:
            return construct(mil) + singrand[1] + " " + cdu
        }
    }
    
    override public func myriade(_ n:Int)-> String {
        let dixmil = ((n-n%10000)/10000)%10000
        
        switch dixmil {
        case 0 :
            return mil(n%10000)
        case 1:
            return masculin[1] + singrand[2] + " " + mil(n%10000)
        case 2:
            return paire + singrand[2] + " " + mil(n%10000)
        default :
            return construct(dixmil) + singrand[2] + " " + mil(n%10000)
        }
    }
    
    override public func mymyriade(_ n:Int)-> String {
        let centmillion = ((n-n%100000000)/100000000)%100000000
        
        switch centmillion {
        case 0:
             return myriade(n%100000000)
        case 1:
            return masculin[1] + singrand[3] + " " + myriade(n%100000000)
            
        case 2:
            return paire + singrand[3] + " " + myriade(n%100000000)
        default:
            return construct(centmillion) + singrand[3] + " " + myriade(n%100000000)
        }
    }
}

public class Romaji:Kanji{
    
    public override init(_ value:Int) {
        super.init(value)
        masculin = ["rei", "ichi", "ni", "san", "yon", "go", "roku", "nana", "hachi", "kyū", "jū"]
        
        singrand = ["hyaku", "sen", "man", "oku", "chō", "kyō", "gai"]
        
        moins = "mainasu"

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
        case 3:
            if n%100 == 0 {
                return "sanbyaku"
            } else {
                return "sanbyaku " + dizunit(n, m)
            }
        case 6:
            if n%100 == 0 {
                return "roppyaku"
            } else {
                return "roppyaku " + dizunit(n, m)
            }
        case 8:
            if n%100 == 0 {
                return "happyaku"
            } else {
                return "happyaku " + dizunit(n, m)
            }
        default:
            if n%100 == 0 {
                return masculin[cent] + singrand[0]
            } else {
                return masculin[cent] + singrand[0] + " " + dizunit(n, m)
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
        case 3:
            return "sanzen " + cdu
        case 8:
            return "hassen " + cdu
        default:
            return construct(mil) + singrand[1] + " " + cdu
        }
    }
}

public class Kana:Kanji{    // ou hiragana
    
    public override init(_ value:Int) {
        super.init(value)
        
        masculin = ["れい", "いち", "に", "さん", "よん", "ご", "ろく", "なな", "はち", "きゅう", "じゅう"]

        singrand = ["ひゃく", "せん", "まん", "おく", "ちょう", "きょう", "がい"]
        
        moins = "マイナス"
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
        case 3:
            if n%100 == 0 {
                return "さんびゃく"
            } else {
                return "さんびゃく " + dizunit(n, m)
            }
        case 6:
            if n%100 == 0 {
                return "ろぴゃく"
            } else {
                return "ろぴゃく " + dizunit(n, m)
            }
        case 8:
            if n%100 == 0 {
                return "はぴゃく"
            } else {
                return "はぴゃく " + dizunit(n, m)
            }
        default:
            if n%100 == 0 {
                return masculin[cent] + singrand[0]
            } else {
                return masculin[cent] + singrand[0] + " " + dizunit(n, m)
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
        case 3:
            return "さんぜん " + cdu
        case 8:
            return "はっせん " + cdu
        default:
            return construct(mil) + singrand[1] + " " + cdu
        }
    }
}

public class Taiwan:Hanzi{
    
    public override init(_ value:Int) {
        super.init(value)
        masculin = ["?", "chit", "ji", "sam", "su", "ngo", "liok", "chhit", "pat", "kiu", "chap"]
        
        singrand = ["pah", "千", "万", "亿", "兆", "京", "垓"]

    }
}

public class Hanja: Hangeul{
    
    public override init(_ value:Int) {
        super.init(value)
        masculin = ["komé", "il", "i", "sam", "sa", "o", "yuk", "chil", "pal", "gu", "sip"]
        
        singrand = ["baek", "cheon", "man", "eok", "jo", "gyeong", "hae"]

    }
}


public class Hangeul: Kanji {
    
    public override init(_ value:Int) {
        super.init(value)
       
        masculin = ["〇", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구", "십"]
        
        singrand = ["백", "천", "만", "억", "조", "경", "해"]
        
    }
}

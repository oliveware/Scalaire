//
//  hexaglyphes model
//
//  Created by Herve Crespel on 18/06/2021.
//

import Foundation
import SwiftUI

public struct Hexaglyphes {
    
    public static private(set) var trigrams: [Trigramdata] = [
        Trigramdata(name:"ciel",pinyin:"qián",ideogram:"乾",v:0),
        Trigramdata(name:"vent",pinyin:"xùn",ideogram:"",v:1),
        Trigramdata(name:"feu",pinyin:"li",ideogram:"離",v:2),
        Trigramdata(name:"montagne",pinyin:"gèn",ideogram:"艮",v:3),
        Trigramdata(name:"brume",pinyin:"dui",ideogram:"",v:4),
        Trigramdata(name:"eau",pinyin:"kǎn",ideogram:"",v:5),
        Trigramdata(name:"tonnerre",pinyin:"gèn",ideogram:"",v:6),
        Trigramdata(name:"terre",pinyin:"kūn",ideogram:"坤",v:7)
    ]
    public static private(set) var hexagrams: [Hexagramdata] = [
            Hexagramdata(name:"créatif, ciel",pinyin:"qián",ideogram:"乾",v:0,num:1),
            Hexagramdata(name:"réceptif",pinyin:"kūn",ideogram:"坤",v:63,num:2),
            Hexagramdata(name:"difficulté initiale",pinyin:"chún",ideogram:"屯",v:46,num:3),
            Hexagramdata(name:"folie juvénile",pinyin:"méng",ideogram:"蒙",v:29,num:4),
            Hexagramdata(name:"attente",pinyin:"xū",ideogram:"需",v:40,num:5),
            Hexagramdata(name:"conflit",pinyin:"sòng",ideogram:"訟",v:5,num:6),
            Hexagramdata(name:"armée",pinyin:"shī",ideogram:"師",v:61,num:7),
            Hexagramdata(name:"solidarité, union",pinyin:"bǐ",ideogram:"比",v:47,num:8),
            Hexagramdata(name:"pouvoir d'approvisionnement du petit",pinyin:"xiǎo chù",ideogram:"小畜",v:8,num:9),
            Hexagramdata(name:"marche",pinyin:"lǚ",ideogram:"履",v:4,num:10),
            Hexagramdata(name:"paix",pinyin:"tài",ideogram:"泰",v:56,num:11),
            Hexagramdata(name:"stagnation",pinyin:"pǐ",ideogram:"否",v:7,num:12),
            Hexagramdata(name:"communauté avec les hommes",pinyin:"tóng rén",ideogram:"同人",v:2,num:13),
            Hexagramdata(name:"grand avoir",pinyin:"dà yǒu",ideogram:"大有",v:16,num:14),
            Hexagramdata(name:"humilité",pinyin:"qiān",ideogram:"謙",v:59,num:15),
            Hexagramdata(name:"enthousiasme",pinyin:"yù",ideogram:"豫",v:55,num:16),
            Hexagramdata(name:"suite",pinyin:"suí",ideogram:"隨",v:38,num:17),
            Hexagramdata(name:"travail sur ce qui est corrompu",pinyin:"gǔ",ideogram:"蠱",v:25,num:18),
            Hexagramdata(name:"approche",pinyin:"lín",ideogram:"臨",v:60,num:19),
            Hexagramdata(name:"contemplation",pinyin:"guān",ideogram:"觀",v:15,num:20),
            Hexagramdata(name:"mordre au travers",pinyin:"shì kè",ideogram:"噬嗑",v:22,num:21),
            Hexagramdata(name:"grâce",pinyin:"bì",ideogram:"賁",v:26,num:22),
            Hexagramdata(name:"éclatement",pinyin:"bō",ideogram:"剝",v:31,num:23),
            Hexagramdata(name:"retour",pinyin:"fù",ideogram:"復",v:62,num:24),
            Hexagramdata(name:"innocence",pinyin:"wú wàng",ideogram:"無妄",v:6,num:25),
            Hexagramdata(name:"pouvoir d'approvisionnement du grand",pinyin:"dà chù",ideogram:"大畜",v:24,num:26),
            Hexagramdata(name:"commissures des lèvres",pinyin:"yí",ideogram:"頤",v:30,num:27),
            Hexagramdata(name:"prépondérance du grand",pinyin:"dà guò",ideogram:"大過",v:33,num:28),
            Hexagramdata(name:"insondable",pinyin:"kǎn",ideogram:"坎",v:45,num:29),
            Hexagramdata(name:"feu",pinyin:"lí",ideogram:"離",v:18,num:30),
            Hexagramdata(name:"influence",pinyin:"xián",ideogram:"咸",v:35,num:31),
            Hexagramdata(name:"durée",pinyin:"héng",ideogram:"恆",v:49,num:32),
            Hexagramdata(name:"retraite",pinyin:"dùn",ideogram:"遯",v:3,num:33),
            Hexagramdata(name:"puissance du grand",pinyin:"dà zhuàng",ideogram:"大壯",v:48,num:34),
            Hexagramdata(name:"progrès",pinyin:"jìn",ideogram:"晉",v:23,num:35),
            Hexagramdata(name:"obscurcissement de la lumière",pinyin:"míng yí",ideogram:"明夷",v:58,num:36),
            Hexagramdata(name:"famille",pinyin:"jiā rén",ideogram:"家人",v:10,num:37),
            Hexagramdata(name:"opposition",pinyin:"kui",ideogram:"睽",v:20,num:38),
            Hexagramdata(name:"obstacle",pinyin:"jiǎn",ideogram:"蹇",v:43,num:39),
            Hexagramdata(name:"libération",pinyin:"xiè",ideogram:"解",v:53,num:40),
            Hexagramdata(name:"diminution",pinyin:"sǔn",ideogram:"損",v:28,num:41),
            Hexagramdata(name:"augmentation",pinyin:"yì",ideogram:"益",v:14,num:42),
            Hexagramdata(name:"percée",pinyin:"guài",ideogram:"夬",v:32,num:43),
            Hexagramdata(name:"venir à la rencontre",pinyin:"gòu",ideogram:"姤",v:1,num:44),
            Hexagramdata(name:"rassemblement",pinyin:"cuì",ideogram:"萃",v:39,num:45),
            Hexagramdata(name:"poussée vers le haut",pinyin:"shēng",ideogram:"升",v:57,num:46),
            Hexagramdata(name:"accablement",pinyin:"kùn",ideogram:"困",v:37,num:47),
            Hexagramdata(name:"puits",pinyin:"jǐng",ideogram:"井",v:41,num:48),
            Hexagramdata(name:"révolution",pinyin:"gé",ideogram:"革",v:34,num:49),
            Hexagramdata(name:"chaudron",pinyin:"dǐng",ideogram:"鼎",v:17,num:50),
            Hexagramdata(name:"ébranlement",pinyin:"zhèn",ideogram:"震",v:54,num:51),
            Hexagramdata(name:"montagne",pinyin:"gèn",ideogram:"艮",v:27,num:52),
            Hexagramdata(name:"développement",pinyin:"jiàn",ideogram:"漸",v:11,num:53),
            Hexagramdata(name:"épousée",pinyin:"guī mèi",ideogram:"歸妹",v:52,num:54),
            Hexagramdata(name:"abondance",pinyin:"fēng",ideogram:"豐",v:50,num:55),
            Hexagramdata(name:"voyageur",pinyin:"lǚ",ideogram:"旅",v:19,num:56),
            Hexagramdata(name:"doux",pinyin:"xùn",ideogram:"巽",v:9,num:57),
            Hexagramdata(name:"lac",pinyin:"dui",ideogram:"兌",v:36,num:58),
            Hexagramdata(name:"dispersion",pinyin:"huàn",ideogram:"渙",v:13,num:59),
            Hexagramdata(name:"limitation",pinyin:"tsié",ideogram:"節",v:44,num:60),
            Hexagramdata(name:"vérité intérieure",pinyin:"zhōng fú",ideogram:"中孚",v:12,num:61),
            Hexagramdata(name:"prépondérance du petit",pinyin:"xiǎo guò",ideogram:"小過",v:51,num:62),
            Hexagramdata(name:"après l'accomplissement",pinyin:"jì jì",ideogram:"既濟",v:42,num:63),
            Hexagramdata(name:"avant l'accomplissement",pinyin:"wèi jì",ideogram:"未濟",v:21,num:64)
        ]

    public init() {
    }
}

public enum Hexastyle {
    case yijing
    case horiz     // h64 horizontal
    case alter     // h64 alterné
}

public struct Yiking {
    let name : String
    let ideogram : String
    let pinyin : String
    let num : Int
    
    public init(name:String, pinyin:String, ideogram:String, num:Int) {
        self.name = name
        self.pinyin = pinyin
        self.ideogram = ideogram
        self.num = num
    }
    
  /*  func tab(_ start:Int, _ end:Int)->[Int] {
        var t : [Int] = []
        var reduce = val
        for _ in start...end {
            let rem = reduce % 2
            t.append(rem)
            reduce = (reduce - rem)/2
        }
        return t
    }*/
    
    func convert(_ t:[Int])->Int {
        var val = 0
        for i in 0..<t.count {
            val = val*2 + t[i]
        }
        return val
    }
    
}

public struct Hexagramdata {
    let yiking: Yiking
    let value: Int
    
    var top : Trigramdata {
        get {
            return Hexaglyphes.trigrams[(value - value%8)/8]
        }
    }
    var bottom : Trigramdata {
        get {
            return Hexaglyphes.trigrams[value%8]
        }
    }
   /*
    var tabin : [Int] {
        get {
            return tab(0,5)
        }
    }
    var topmaster: Trigramdata {
        get {
            return Hexaglyphes.trigrams[convert(tab(1,3))]
        }
    }
    var botmaster: Trigramdata {
        get {
            return Hexaglyphes.trigrams[convert(tab(2,4))]
        }
    }*/
    
    public init(name:String,pinyin:String,ideogram:String,v:Int,num:Int) {
        value = v
        yiking = Yiking(name:name, pinyin: pinyin,ideogram : ideogram, num:num)
    }
    
    static func lookup(_ value:Int) -> Int {
        let hexagrams = Hexaglyphes.hexagrams
        var index = 0
        for hexagram in hexagrams {
            if hexagram.value == value {
                index = hexagram.yiking.num - 1
            }
        }
        return index
    }
    
    static func byvalue(_ value:Int) -> Hexagramdata {
        return Hexaglyphes.hexagrams[Hexagramdata.lookup(value)]
    }

    func next() -> Hexagramdata{
        let num = yiking.num
        return Hexaglyphes.hexagrams[num == 64 ? 0 : num]
    }
    func prev() -> Hexagramdata{
        let num = yiking.num
        return Hexaglyphes.hexagrams[num == 1 ? 63 : num-2]
    }

}

public struct Trigramdata {
    public let yiking: Yiking
    public let value : Int
    public let high : Bool
    public let middle : Bool
    public let low : Bool
    
    var mat: [Int] {
        get{
            var t: [Int] = []
            t.append(high ? 1 : 0)
            t.append(middle ? 1 : 0)
            t.append(low ? 1 : 0)
            return t
        }
    }
   init(name:String, pinyin:String, ideogram:String, v:Int) {
       yiking = Yiking(name:name, pinyin: pinyin, ideogram : ideogram, num:v)
       value = v
        low = v%2 == 1
        middle = ((v - v%2)/2)%2 == 1
        high = v > 3
    }
    
    func next() -> Trigramdata{
        return Hexaglyphes.trigrams[value == 7 ? 0 : value+1]
    }
    func prev() -> Trigramdata{
        return Hexaglyphes.trigrams[value == 0 ? 7 : value-1]
    }
}

enum Conversion {
    case hexa
    case tri
    case top
    case bottom
}




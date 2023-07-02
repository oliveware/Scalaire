//
//  Digroupe.swift
//  Knownbers (iOS)
//
//  Created by Herve Crespel on 14/06/2022.
//

import SwiftUI

struct Digroup: View {

    var index = 0
    var suitindex = 0
    var groupindex = 0

    var groupower : Int {
        scalars[index][suitindex].count - groupindex - 1
    }
    // indispensable pour raffraîchir l'affichage
    var valuepower : Int {
        if scalars[index].count == 1 { scalars[index].append([]) }
        if scalars[index].count == 0 { scalars[index] = [[],[]] }
        let nbg = scalars[index][suitindex].count
        if  nbg == 0 {
            scalars[index][suitindex].append([])
            return 0
        } else {
            if groupindex < nbg {
                return scalars[index][suitindex][groupindex].count
            } else {
                return 0
            }
        }
    }
    
    // ["", "十", "百", "千"]
    var low : [String] { classifiers.low }
    //["", "万", "億", "兆", "京", "垓"]
    var high : [String] { classifiers.high }
    // [["〇", "一", "二", "三", "四", "五", "六", "七", "八", "九"]]
    var glyphes : [[String]] { glyphes }
  //  var group:[Int]  { scalars[0][1][0] }
    
    
    var graphism : Graphism {
        boulier ? .boulier : graphism
    }
    var groupby: Int { groupby}
    
    func visible(_ i:Int) -> Bool {
        if scalars[index][suitindex].count == 0 {
            return true
            
        } else {
            let group = scalars[index][suitindex][groupindex]
            if group[i] != 0 {
                return true
            } else {
                switch numicode {
                case .hanzi:
                    switch i {
                    case 0:
                        return groupindex > 0
                    case 1:
                        if valuepower > 1 {
                            return group[0] != 0
                        } else {
                            return false
                        }
                    case 2:
                        if valuepower == 3 {
                            if group.count > 3 {
                                return (group[1] != 0 && group[3] != 0) || (group[1] == 0)
                            } else {
                                return group[1] != 0
                            }
                        } else {
                            return false
                        }
                    default:
                        return false
                    }
                case .kanji,.kor:
                    return false
                case .roman, .greek, .aegypt:
                    return false
                default:
                    return true
                }
            }
        }
    }
    
    func classifier(_ i : Int) -> String {
        if valuepower == 0 {
            return ""
        } else {
            return low.count < 2 ? "" : low[valuepower - 1 - i]
        }
    }
    
    func pave(_ i:Int = 0) -> [String] {
        let nbp = glyphes.count
        if nbp == 1 {
            return glyphes[0]
        } else {
            if valuepower == 0 {
                return glyphes[nbp-1]
            } else {
                let power = (groupby * groupower + valuepower - 1 - i) % nbp
                return glyphes[nbp-1-power ]
            }
        }
    }
    
    var body: some View {
        HStack(spacing:0) {
            if numicode == .cister {
                Cistercien(index:index, suitindex:suitindex, groupindex:groupindex,
                    size: digitsize * 2)
                  //  size:selection.count < 2 ? 40 : 30,
                  //  finesse: selection.count < 2 ? 3 : 1.5)
            } else {
                if valuepower > 0 {
                    ForEach(0..<valuepower, id: \.self) {
                        i in
                        if visible(i) {
                            Chiffre(
                              //  pave:pave(i),
                                value:scalars[index][suitindex][groupindex][i],
                                classifier: classifier(i),
                                graphism:graphism,
                                size: digitsize
                            )
                        }
                    }
                    if high.count > 0  && graphism != .boulier  {
                        Text(high[groupower])
                    }
                } else {
                    if suitindex == 0 && scalars[index][0] == [] && scalars[index][1] != [] && scalars[index][1] != [[]] {
                        Chiffre(
                          //  pave:pave(0),
                            value:0,
                            graphism:graphism
                        )
                    }
                }
        }
        }.padding(0)
    }
}

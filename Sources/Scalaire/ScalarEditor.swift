//
//  ScalarEditor.swift
//  Unicalc
//
//  Created by Herve Crespel on 28/06/2022.
//

import SwiftUI

public enum ScalarSet: String {
    case N  = "naturel"
    case Z  = "relatif"
    case Q  = "rationnel"
    case I  = "irrationnel"
    case R  = "réel"
}

struct ScalarEditor: View {
    @ObservedObject var unicode: UnicodePresentation
    var mesure = Mesure()
    
    var index = 0

    var set : ScalarSet { sets[index] }
   
    var selected: Bool {
        if selection.count > 0 {
            return selection[0] == index
        } else {
            return false
        }
    }

    var decdenempty: Bool {
        var dendecempty: Bool
        if scalars[index].count > 1 {
            if scalars[index][1].count == 0 {
             //   sets[index] = signs[index] ? .Z : .N
                dendecempty = true
            } else {
                dendecempty = scalars[index][1] == []
            }
        } else {
            dendecempty = true
        }
        return dendecempty
    }
    var showden: Bool {
         return !decdenempty && sets[index] == .Q
    }
    var showdot : Bool {
        return !decdenempty && (sets[index] == .R || sets[index] == .I)
    }
    
  func barwidth() -> CGFloat {
      let left = unicode.left
      if left.count == 0 {
          return 0
      } else {
          let charsize : CGFloat = 22 // Text(unicode.left[0]).fixedSize()
          
          return CGFloat(unicode.barge(scalarset, groupby)) * charsize
      }
    }
    
    var body: some View {
        
            HStack {
                if !(index == 0 && scalarset == .N) {
                    Button(action:norz)
                    { Signe(negative: signs[index], first: index == 0) }
                        .plumoins(size: 15)
                }
                VStack(alignment:.center,spacing: 0){

                    // numérateur
                    HStack(spacing: 0){
                        GroupSuit(index:index, kind:0)
                        .frame( alignment: .trailing)
                        if scalarset == .I || scalarset == .R {
                            if showdot {
                                Dot().padding(2)
                            }
                            if selected || !showden {
                                GroupSuit(index:index, kind:1, align:.leading)
                                .frame(alignment: .leading)
                            }
                        }
                    }
                    .frame(minWidth: mesure.width/3)
                    if scalarset == .Q  {
                        // dénominateur
                        if set == .Q && dendec != [] {
                            Rectangle().fill(Color("glyph"))
                                .frame(width:barwidth(), height: 2)
                        }
                        if selected || showden {
                            GroupSuit(index:index, kind:2, align:.center)
                        }
                    }
                }.frame(minWidth: 100)
            }.frame(minWidth:100)
    }
    
    func norz() {
        signs[index].toggle()
        let set = sets[index]
        switch signs[index] {
        case true:
            if set == .N { sets[index] = .Z }
        case false:
            if set == .Z { sets[index] = .N }
        }
    }
    
    var dendec : [[Int]] {
        if scalars[index].count == 1 {
            scalars[index].append([])
        }
        return scalars[index][1]
        
    }
    
   /* func decimal() {
        sets[index] = .I
        if scalars[index].count == 1 { scalars[index].append([]) }
    }
    
    func rational() {
        sets[index] = .Q
        if scalars[index].count == 1 { scalars[index].append([]) }
    }
    
    var nument : [[Int]] {
        if scalars[index].count == 0 {
            scalars[index].append([])
        }
        return scalars[index][0]
        
    }
    

    var entlarge: CGFloat {
        let carlarge = clavier == .simple ? 15 : 20
        var large = 0
            
            for i in 0..<nument.count {
                large += nument[i].count * carlarge
            }
        
            return  CGFloat(large)*size

    }
    var declarge: CGFloat {
       let carlarge = clavier == .simple ? 15 : 20
       var large = 0

           for i in 0..<dendec.count {
               large += dendec[i].count * carlarge
           }

           return   CGFloat(large)*size

    }

    var large: CGFloat {
        let carlarge = clavier == .simple ? 15 : 20
        var numlarge = carlarge*2
        var denlarge = carlarge*2
            
            for i in 0..<nument.count {
                numlarge += nument[i].count * carlarge
            }
            for i in 0..<dendec.count {
                denlarge += dendec[i].count * carlarge
            }

            return numlarge > denlarge ? CGFloat(numlarge)*size : CGFloat(denlarge)*size

    }*/
    
    
}

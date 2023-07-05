//
//  Unipad.swift
//  Knownbers
//
//  Created by Herve Crespel on 18/06/2022.
//

import SwiftUI

struct Unipad: View {
    @Binding var scalar: Scalar
    var base:Int = 10
        
    var graphism:Graphism
    var width:CGFloat = 600
    var height:CGFloat = 400
    
    var linear = false
    
    @State var i = 0
    
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(spacing:2) {
                ForEach(ranges, id: \.self) {
                    range in
                    HStack(spacing:2) {
                        ForEach(range, id: \.self) {
                            value in
                            Button( action: { input(value) } )
                                { Chiffre(
                                    value: value,
                                    graphism:graphism,
                                    size: ht/3
                                )
                                }
                                .modern(w: wt, h:ht)
                             // .keyboardShortcut(key)
                                .disabled(value==0)
                        }
                    }.padding(0)
                }
            }
            .padding(0)
        }.frame(width: width, height: height, alignment: .center)
        .padding(0)
        
    }
    
    func input (_ value:Int) {
        scalar.add(value)
        i += 1
    }
    
    // calcul du nombre de colonnes et de lignes
    
    var ranges:[ClosedRange<Int>] {
        let nbchiffres = base
        if linear {
            switch nbchiffres {
            case 20,30,40:
                return lines(10)
            case 24,36,48:
                return lines(12)
            default:
                return lines(16)
            }
        } else {
            switch nbchiffres {
            case 2,3:
                return[0...nbchiffres-1]
            case 4:
                return lines(2)
            case 5:
                return[0...0, 1...2, 3...4]
            case 6,9,12,15:
                return lines(3)
            case 7...28:
                return lines(4)
            case 40...59:
                return lines(6)
            case 60...72:
                return lines(8)
            default:
                return lines(Int(sqrt(Double(nbchiffres-1))) + 1)
            }
        }
    }
        
    func lines(_ nbc:Int)->[ClosedRange<Int>] {
        var rg :[ClosedRange<Int>] = []
        let nbchiffres = base
        let last = nbchiffres % nbc
        let nbl = (nbchiffres - last) / nbc
        if nbl > 0 {
            for i in 1...nbl {
                rg.append((i-1)*nbc...i*nbc-1)
            }
        }
        if last > 0 {
            rg.append(nbchiffres-last...nbchiffres-1)
        }
        return rg
    }
    
    var wt:CGFloat{
        let w = width - 60
        if base == 5 {
            return (w-6)/2
        } else {
            let nbc = CGFloat(ranges[0].count)
            let wt = w-2*(nbc+1)
            return linear ? wt/(nbc+1) : wt/nbc
        }
    }
    
    var ht:CGFloat {
        let nbl = CGFloat(ranges.count)
        return (height-30 - 2*(nbl-1))/nbl
    }
}


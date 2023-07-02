//
//  UnaryDigit.swift
//  Unicalc
//
//  Created by Herve Crespel on 01/08/2022.
//

import SwiftUI

enum Unarstyle:LocalizedStringKey {
    case bat    = "unarstyle.bat"
    case gbat   = "unarstyle.gbat"
    case barre  = "unarstyle.barre"
    case diag   = "unarstyle.diag"
    case arame  = "unarstyle.arame"
    case aramh  = "unarstyle.aramh"
    case palmyre = "unarstyle.palmyre"
    case minoan = "unarstyle.minoan"
    case carunar = "unar.carre"
    case V = "unarstyle.V"
    case X = "unarstyle.X"
}
var unarstyles:[Unarstyle] = [.bat, .gbat, .barre, .diag, .arame, .V, .aramh, .minoan, .palmyre, .carunar, .X]

struct UnaryDigit: View {
    var value = 3
    var size :CGFloat = 10
    var color = Color("glyph")
    var style : Unarstyle = .bat

    
    
    var upb : Int {  // units per block
        (style == .X || style == .arame ) ? 10 : 5
    }
    
    var nu:Int {
        value % upb
    }
    
    var nb:Int {
        (value - nu) / upb
    }
    
    var body: some View {
        

        HStack(spacing:style == .bat ? size/2 : style == .carunar ? 0 : size) {
            if nb > 0 {
                ForEach(0..<nb, id: \.self) {
                    _ in
                    switch style {
                    case .barre, .diag, .gbat, .bat:
                        Unarblock(value:upb, size:size, color:color, style:style)
                    case .V, .X:
                        Unartext(value:upb, size:size, color:color, style:style)
                    case .carunar:
                        Glyshape(value:5, weight: 2,
                                 set:carunar)
                            .frame(width:5*size,height: 5*size)
                    case .arame:
                        // correct si value < 20
                        Glyshape(value:value > 9 ? value-9 : 0,
                                 set:aramegypt)
                            .frame(width:6*size,height: 6*size)
 
                    default:
                        Text(value > 9 ? "?" : "")
                    }
                }
            }
            if nu >= 0 {
                switch style {
                case .barre, .diag, .gbat, .bat:
                    Unarblock(value:nu, size:size, color:color, style:style)
                case .V, .X:
                    Unartext(value:nu, size:size, color:color, style:style)
                case .arame:
                    Glyshape(value:value > 9 ? 10 : nu,
                             set:aramegypt)
                        .frame(width:6*size,height: 6*size)
                        .offset(x:value > 9 ? -size*2.5 : 0, y: 0)
                case .aramh:
                    Glyshape(value:value > 9 ? 10 : value,
                             set:arameso)
                        .frame(width:7*size,height: 7*size)
                case .carunar:
                    Glyshape(value:nu, weight: 2,
                             set:carunar)
                        .frame(width:5*size,height: 5*size)
                case .minoan:
                    Glyshape(value:value, weight: 2,
                             set:minoan)
                    .frame(width:7*size,height: 7*size)
                default:
                    Text("tbd")
                }
            }
            }
    }

}


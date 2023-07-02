//
//  Chiffrenboules.swift
//  Unicalc
//
//  Created by Herve Crespel on 27/09/2022.
//

import SwiftUI

@available(macOS 10.15, *)
struct Chiffrenboules: View {
    @State var value: Int = 7
    var base = 10
    // hauteur d'une boule
    var hb = 25.0
    // nombre de boules
    var haut = 2
    var bas = 5
    var pow = 5
    
    var pilebas : Int { value - pilehaut * pow }
    var pilehaut : Int {
        var nb = 0
        for i in 0...haut {
            if (haut-i)*pow <= value {
                nb = haut-i
                break
            }
        }
        return nb
    }
    // [[haut-nhaut, nhaut],[nbas, bas-nbas]]

    
    var hautige: CGFloat {CGFloat(haut + bas + 6) * (hb+0.7)}
    var largeur: CGFloat {hb*2.5}
    
    var body: some View {

        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.green)
                .frame(width: hb*0.35, height: hautige)
            VStack {
                VStack(spacing:0.5) {
                    Pileboule(value:$value, pow:pow,
                        haut: haut - pilehaut,
                        bas:pilehaut,
                        hb:hb, color:Color.orange)
                    .padding(.bottom, 4)
                
                    Rectangle().fill(Color.gray)
                        .frame(width:hb*2, height: hb)
                       // .offset(y:-1)

                    Pileboule(value:$value, pow:1,
                        haut: pilebas,
                        bas: bas - pilebas,
                        hb:hb)
                }
                
            }
        }.padding(0)
            .frame(height:hautige,alignment: .center)
    }
}


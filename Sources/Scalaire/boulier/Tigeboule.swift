//
//  Tigeboule.swift
//  multikalk
//
//  Created by Herve Crespel on 22/11/2021.
//

import SwiftUI

struct Tigeboule: View {
    @ObservedObject var tige: Tige
    var width: CGFloat = 40
    var height: CGFloat = 150
    
    var wb : CGFloat {
        width*0.85
    }
    var hb : CGFloat {
        height / (tige.height*1.12)
    }
    
    var body: some View {

        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.green)
                .frame(width: wb*0.2, height: height)
            VStack(spacing:0) {
                Pileboule(pile:tige.piles[0],  wb:wb,
                    hb:hb, color:Color.orange)
                if tige.piles.count > 1 {
                    ForEach(1..<tige.piles.count, id: \.self) {
                        pilindex in
                        Rectangle().fill(Color.gray)
                            .frame(width:width, height: hb)
                           // .offset(y:-1)

                        Pileboule(pile:tige.piles[pilindex], wb:wb,
                            hb:hb)
                    }
                }
                
                
            }
        }//.padding(0)
        .frame(width:width, height:height, alignment: .center)
    }
}


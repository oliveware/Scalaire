//
//  BarStack.swift
//  multikalk
//
//  Created by Herve Crespel on 23/11/2021.
//

import SwiftUI

@available(macOS 10.15, *)
struct BarStack: View {
    var nb = 3
    var size :CGFloat = 10
    var color = Color("glyph")
    
    var bar: some View {
        Rectangle().fill(color)
            .frame(width:size*5.5, height: size*0.9)
    }
    
    var body: some View {
        if nb > 0 {
            let rg = 0..<nb
            VStack(spacing:size*0.6) {
                ForEach(rg, id: \.self) {
                    index in
                    bar
                }
            }
        }
    }
}



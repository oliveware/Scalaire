//
//  Vbar.swift
//  Unicalc
//
//  Created by Herve Crespel on 01/08/2022.
//

import SwiftUI

@available(macOS 10.15, *)
struct Vbar: View {
    var size :CGFloat = 10
    var color = Color("glyph")
    
    var body: some View {
        Rectangle().fill(color)
            .frame(width:size*0.4, height: size*4)
    }
}


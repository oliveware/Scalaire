//
//  Chiffrenbase10.swift
//  multikalk
//
//  Created by Herve Crespel on 22/11/2021.
//

import SwiftUI

struct Chiffrenbase10: View {
    var chiffres = [1,2,3,4,5,6,7,8,9]
    var size = 40.0
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<chiffres.count, id: \.self) {
               i in
                Text(String(chiffres[i]))
                    .frame(width: size, height: 35, alignment: .center)
                    .font(.title)
            }
        }.padding(2)
    }
}


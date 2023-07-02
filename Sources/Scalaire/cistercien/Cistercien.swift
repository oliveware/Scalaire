//
//  Cistercien.swift
//  Unicalc (iOS)
//
//  Created by Herve Crespel on 14/07/2022.
//

import SwiftUI

public struct Cistercien: View {
    var value: Int
    var size: CGFloat = 50
    var color = Color("glyph")
    
    var group:[Int] {
        
        var val = [0,0,0,0]
        if value == 0 {
            return val
        } else {
            let group = suite[groupindex]
            switch group.count {
            case 0:
                break
            case 1:
                val[3] = group[0]
            case 2:
                val[2] = group[0]
                val[3] = group[1]
            case 3:
                val[1] = group[0]
                val[2] = group[1]
                val[3] = group[2]
            default:
                val = group
            }
            return val
        }
    }
    
    var body: some View {

        Group{
            HStack(spacing:0) {
                VStack(spacing:size) {
                    Cistdiz(value:value[2], size:size)
                    Cistmil(value:value[0], size:size)
                }.frame(alignment:.trailing)
                Rectangle().fill(color)
                    .frame(width:size/10, height: size*3)
                    .padding(0)
                VStack(spacing:size) {
                    Cistunit(value:value[3], size:size)
                    Cistcent(value:value[1], size:size)
                }.frame(alignment:.leading)
            }
        }.padding(0)

    }
}


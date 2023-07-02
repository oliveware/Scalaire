//
//  Barre.swift
//  hexagram
//
//  Created by Herve Crespel on 19/06/2021.
//

import SwiftUI

@available(macOS 10.15, *)
struct Barre: View {
    var bin = true
    var conf = Digiconfig(.yijing)
    let epais = 0.12
    
    var yang: some View {
        Rectangle().fill(conf.color)
            .frame(width:conf.size, height: conf.size*epais)
    }
    var yin: some View {
        HStack {
            Rectangle().fill(conf.color)
                .frame(width:conf.size/3, height: conf.size*epais)
            Spacer()
            Rectangle().fill(conf.color)
                .frame(width:conf.size/3, height: conf.size*epais)
        }.frame(width:conf.size)
    }
    var hun: some View {
        Rectangle().fill(conf.color)
            .frame(width:conf.size, height: conf.size*epais)
    }
    var hero: some View {
        Rectangle().stroke(conf.color, style:.init(lineWidth: conf.size * epais/20))
            .frame(width:conf.size, height: conf.size*epais*1.1)
    }
    var vun: some View {
        Rectangle().fill(conf.color)
            .frame(width:conf.size*epais, height: conf.size)
    }
    var vero: some View {
        Rectangle().stroke(conf.color, style:.init(lineWidth: conf.size * epais/20))
            .frame(width:conf.size*epais*1.1, height: conf.size)
    }
    
    var body: some View {
        switch conf.style {
            
        case .yijing :
            if bin {
                yin
            } else {
                yang
            }
        case .horiz :
            if bin {
                hun
            } else {
                hero
            }
        case .alter :
            if bin {
                vun
            } else {
                vero
            }
        }
    }

}

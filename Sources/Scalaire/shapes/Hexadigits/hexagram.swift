//
//  hexagram.swift
//  hexagram
//
//  Created by Hervé Crespel on 11/06/2023.
//

import SwiftUI

@available(macOS 10.15.0, *)
public struct Hexagram: View {
    public var hexagram : Hexagramdata
    public var iconly = false
    public var conf = Digiconfig(.yijing)
    public var name: some View {
        VStack(spacing:10) {
            Text("\(hexagram.yiking.num)")
                .font(.title)
                .padding(10)
            Text(hexagram.yiking.name)
            Text("\(hexagram.yiking.ideogram)  \(hexagram.yiking.pinyin)")
                .font(.title)
                
        }.padding()
        .frame(width: 300, height: 150)
    }
    
    public var glyph: some View {
        VStack(spacing:conf.size/20) {
            Barre(bin:hexagram.top.high, conf:conf)
            Barre(bin:hexagram.top.middle, conf:conf)
            Barre(bin:hexagram.top.low, conf:conf)
            
            Barre(bin:hexagram.bottom.high, conf:conf)
            Barre(bin:hexagram.bottom.middle, conf:conf)
            Barre(bin:hexagram.bottom.low, conf:conf)
        }
    }
    
    public var body: some View {
       
        if iconly {
            glyph
        } else {
            GroupBox {
                HStack {
                    name
                    glyph
                    Text("\(hexagram.value)")
                    .font(.title)
                    .padding(10)
                    
                }
            }
        }
    }
}

//
//  Trigramdata.swift
//  hexagram
//
//  Created by Hervé Crespel on 10/06/2023.
//

import SwiftUI

@available(macOS 10.15.0, *)
public struct Trigram: View {
    var data : Trigramdata
    var iconly = false
    var config: Digiconfig
    
    var name: some View {
        VStack(spacing:10) {
            Text(data.yiking.name)
            Text("\(data.yiking.ideogram)  \(data.yiking.pinyin)")
                .font(.title)
        }.padding()
        .frame(width: 100, height: 120)
    }
    
    var glyph: some View {
        VStack(spacing:config.size/20) {
            Barre(bin:data.high, conf: config)
            Barre(bin:data.middle, conf: config)
            Barre(bin:data.low, conf: config)
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
                    Text("\(data.value)")
                        .font(.title)
                        .padding(10)
                }
            }
        }
    }
}

@available(macOS 10.15.0, *)
public struct TrigramPanel: View {
    var config = Digiconfig(.yijing)
    
    public init(_ conf:Digiconfig = Digiconfig(.yijing)) {
        config = conf
    }
    
    public var body:some View {
        HStack(spacing:10){
            VStack(spacing:10) {
                ForEach(0..<4) {
                    val in
                    Trigram(data:Hexaglyphes.trigrams[val], config: config)
                }
            }
            VStack(spacing:10) {
                ForEach(4..<8) {
                    val in
                    Trigram(data:Hexaglyphes.trigrams[val], config: config)
                }
            }
        }
    }
}


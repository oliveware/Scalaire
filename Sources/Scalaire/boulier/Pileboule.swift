//
//  Pileboule.swift
//  multikalk
//
//  Created by Herve Crespel on 22/11/2021.
//

import SwiftUI

struct Pileboule: View {
    @ObservedObject var pile:Pile
    
    var wb = CGFloat(45)
    var hb = CGFloat(25)
    var color = Color.yellow
    
    var height:CGFloat {
        (hb*1.12 )*(CGFloat(pile.height))
    }
    
    var body: some View {
        
        VStack(spacing: hb*0.05) {
            if pile.actif > 1 {
                ForEach(0..<pile.actif-1, id: \.self) {
                    i in
                    Boule(color: color, width:wb, height:hb)
                }
            }
            
            if pile.actif > 0 {
                Button (action: deactivate) {
                    Boule(color: color, width:wb, height:hb)
                }.boule(w: wb, h: hb)
                    .offset(y:-hb*0.05)
                HStack{}.frame(width:hb,height:hb)
            }
            
            if pile.passif > 0 {
                HStack{}.frame(width:wb, height: pile.actif == 0 ? hb*1.15 : 0)
                Button (action: activate) {
                    Boule(color: color, width:wb, height:hb)
                }.boule(w: wb, h: hb)
                    .offset(y:hb*0.05)
            }
            
            if pile.passif > 1 {
                ForEach(0..<pile.passif - 1, id: \.self) {
                    i in
                    Boule(color: color, width:wb, height:hb)
                }
            }
        }.frame(height:height, alignment: .top)
        .padding(0)
    }
    
    func activate() {
        pile.activate() ? 1 : 0
    }
    
    func deactivate() {
       pile.deactivate() ? -1 : 0
    }
    
}


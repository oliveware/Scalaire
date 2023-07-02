//
//  Interactige.swift
//  Unicalc
//
//  Created by Herve Crespel on 24/09/2022.
//

import SwiftUI

struct Interactige: View {

    @EnvironmentObject var abacus: Abacus
    @ObservedObject var tige: Tige
    
    var width:CGFloat = 50
    var height:CGFloat = 300
    var group = 0
    var chiffre = 2

    @State var value = 0
    @Binding var edited: [Int]
    
    var bw:CGFloat {width * 0.5}
    var bh:CGFloat {width * 0.3}
    
    var avechiffre = false
    
    var power: String {
        var pmax = 1
        for _ in 1..<abacus.groupby {
            pmax *= abacus.base
        }
        var p = pmax
        for _ in 0..<chiffre {
            p /= abacus.base
        }
        return String(p)
    }

    var body: some View {

        VStack(alignment:.center,spacing: 0) {
            Text(power)
            HStack{
                if edited == [group, chiffre]  {
                    Button(action:plus){
                        Image(systemName: "plus")
                    }.param(w: bw, h: bh)
                }
            }.frame(height:bh*2)
                .padding(.bottom,10)
            Button(
                action:{
                        if edited == [group, chiffre] {
                            edited = []
                        } else {
                            edited = [group, chiffre]
                        }
                    }
                )
                {
                    Tigeboule(tige:tige, width:width, height:height-bh*2)
                }.tige(w: width, h: height-2*bh)
            HStack{
                if edited == [group, chiffre] {
                    Button(action:moins){
                        Image(systemName: "minus")
                    }.param(w: bw, h: bh)
                }
            }.frame(height:bh*2)
                .padding(.top, 10)
            if avechiffre {
                VStack {
                  //  Text(String(tige.value)).font(.title)
                }.frame(height:bh*2,alignment: .bottom)
            }
        }.frame(alignment:.center)
            .padding(0)
    }
    
    func plus() {  
       // face.count(1)
        tige.plus()
    }
    
    func moins() {
       // face.count(-1)
        tige.moins()
    }


}


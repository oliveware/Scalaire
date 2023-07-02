//
//  Boulier.swift
//  multikalk
//
//  Created by Herve Crespel on 22/11/2021.
//

import SwiftUI

struct Boulier: View {
    @EnvironmentObject var abacus : Abacus
    var mesure = Mesure()
    var largeur :CGFloat { mesure.width - 200}
    var hauteur :CGFloat { mesure.height - 200}
    
   @State var choice = false
    @State var start = true
    @State var edited = [-1, -1]
    
    var bs:CGFloat = 40
    
    var powerbase: Int {
        var pb  = 1
        for _ in 0..<abacus.groupby {
            pb *= abacus.base
        }
        return pb
    }
    
   /* func groupower(_ groupindex:Int) -> String {
        
        let gmax = Int(face.abacus.nbtiges/face.groupby)-1
        var pmax = 1
        for _ in 0..<gmax {
            pmax *= powerbase
        }
        var gv : Int = pmax
        if groupindex == 0 {
            return String(pmax)
        } else {
            for _ in 0..<groupindex {
                gv /= powerbase
            }
            return String(gv)
        }
    }*/
    
    var body: some View {
        if choice {
            AbacusChoice(choice:$choice, autrebase:false)
        } else {
            
            ZStack(alignment:.center) {
                if start {
                    VStack {
                        Text("bouliertitre")
                            .frame(height: 70, alignment: .center)
                            .font(.title).padding(20)
                        
                        Button(action:reset) { Image(systemName: "play") }
                            .fond(w: 100, h: bs)
                    }
                } else {
                    HStack(spacing: 0) {
                        ForEach(0..<abacus.tigroups.count, id: \.self) {
                            groupindex in
                            GroupeTige(tigroup:abacus.tigroups[groupindex])
                                    .frame(height: hauteur+120)
                                    .padding(0)
                        }
                        
                    }.frame(width:largeur, height: hauteur + 120, alignment: .center)
                    HStack{}
                        .frame(width:largeur, height: hauteur*0.95)
                        .border(Color.gray, width:7)
                        .padding(0)
                    
                }
            }.frame(width:mesure.width, height: mesure.height, alignment: .center)
        }
        }
    func reset() {
        
      //  face.setvalue(0)
        start = false
    }
    
}


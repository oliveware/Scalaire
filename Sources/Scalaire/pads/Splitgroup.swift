//
//  Splitgroup.swift
//  Unicalc
//
//  Created by Herve Crespel on 05/07/2022.
//

import SwiftUI

struct Splitgroup: View {

    @State var selected = -1
    
    func select(_ r:Int) {
        print(selected, face.selection)
        if selected == r {
            selected = -1
          /*  if face.selection.count == 4 {
                face.selection.remove(at: 3)
            }*/
        } else {
            if face.selection.count == 3 {
                face.selection.append(r)
            } else {
                face.selection[3] = r
            }
            selected = r
        }
        print(selected, face.selection)
    }
    
    var nblank: Int {
        face.groupby - face.selectedgroup.count
    }
    
    var body: some View {
        HStack(alignment:.top) {
            ForEach(0..<face.groupby, id: \.self) {
                r in
                VStack {
                    Button(action: {select(r)} )
                    {
                        if r < nblank {
                            Text(face.glyphes[0][0])
                            .frame(width: 60, height: 40)
                        } else {
                            Chiffre(
                             //   pave:face.glyphes[0],
                                value:face.selectedgroup[r-nblank],
                                graphism:face.graphism
                            )
                        }
                    }
                    .buttonStyle(Selector())
                    .disabled(selected == r )
                    .frame(width: 60, height: 40)
                    .background(selected == r ? Color("showback") : .clear)
                    
                    if selected == r {
                        Text(face.digipowers.count > r ? face.digipowers[r] : "")
                        .font(.title)
                    }
                }
            }
            if face.clavier == .chinois {
                Text(face.groupclassifier)
                .font(.title)
                .frame(width: 60, height: 40)
            }
        }
    }
}

struct Splitgroup_Previews: PreviewProvider {
    static var previews: some View {
        Splitgroup()
            .environmentObject(Manager(.arab, 10, Vector(Real(489))))
        Splitgroup(selected: 1)
            .environmentObject(Manager(.greek, 10, Vector(Real(489))))
        Splitgroup(selected: 1)
            .environmentObject(Manager(.kanji, 10, Vector(Real(489))))
        HStack {
            Splitgroup(selected: 0)
            Splitgroup(selected: 1)
            Splitgroup(selected: 2)
        }
                .environmentObject(Manager(.kor, 10, Vector(Real(2589))))
        Splitgroup(selected: 0)
            .environmentObject(Manager(.hanzi, 10, Vector(Real(489))))
    }
}

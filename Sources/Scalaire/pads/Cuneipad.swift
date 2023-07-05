//
//  Cuneipad.swift
//  multikalk
//
//  Created by Herve Crespel on 23/11/2021.
//

import SwiftUI

struct Digit60: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

  func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
          .frame(width: 120, height: 50)
          .font(.largeTitle)
          .padding(1)
          .foregroundColor(configuration.isPressed ? Color.green : .pink)
          .background(isEnabled ? Color.yellow : .gray)
          .cornerRadius(8)
  }
}

struct Compose {
    let units : [String]
    let tens : [String]
    var chiffres : String = ""
    var done = false
    private var doublecunei:DoubleCunei
    var value:Int {doublecunei.value}
    init (_ numicode:Numicode, _ base:Int = 10) {
        doublecunei = DoubleCunei(numicode, base)
        let glyphes = doublecunei.glyphes
        units = glyphes[1]
        tens = glyphes[0]
    }
    mutating func add(_ value:Int) {
        doublecunei.add(value)
        chiffres = doublecunei.chiffres
        doublecunei.done = value < 10
        done = value < 10
    }
    mutating func reset() {
        done = false
        chiffres = ""
        doublecunei.reset()
    }
}

struct Cuneipad: View {
    @Binding var scalar: Scalar
    var base:Int = 10
    @State var compose: Compose
    @State var empty = true
    
    var size: CGFloat = 500
    var width:CGFloat = 200
    var height:CGFloat = 180

    
    var body: some View {
        VStack {
            HStack(alignment:.top) {
                Button(compose.chiffres, action: { add() } )
                    .buttonStyle(Digit60())
                    .disabled(empty && !compose.done)
            }.frame(width:width)
                .padding(.top, 5)
                .padding(.bottom,20)
            
            HStack {
                if base > 10 {
                    VStack {
                        Cuneitouche(compose:$compose, value:10)
                            if base > 20 {
                            Cuneitouche(compose:$compose, value:20)
                           
                        }
                        if base > 30 {
                            Cuneitouche(compose:$compose, value:30)
                            if base > 40 {
                            Cuneitouche(compose:$compose, value:40)
                        }
                            if base > 50 {
                                Cuneitouche(compose:$compose, value:50)
                                if base > 60 {
                                    Cuneitouche(compose:$compose, value:60)
                                }
                                if base > 70 {
                                Cuneitouche(compose:$compose, value:70)
                                }
                            }
                        }
                    }.padding(.trailing, 15)
                    .disabled(!(compose.chiffres == ""))
                }
                VStack {
                    HStack {
                        Cuneitouche(compose:$compose, value:1)
                        Cuneitouche(compose:$compose, value:2)
                    }
                    if base > 3 {
                    HStack {
                        Cuneitouche(compose:$compose, value:3)
                        Cuneitouche(compose:$compose, value:4)
                    }
                        if base > 5 {
                        HStack {
                        Cuneitouche(compose:$compose, value:5)
                        Cuneitouche(compose:$compose, value:6)
                    }
                        if base > 7 {
                        HStack {
                            Cuneitouche(compose:$compose, value:7)
                            Cuneitouche(compose:$compose, value:8)
                        }
                            if base > 7 {
                            HStack {
                            Cuneitouche(compose:$compose, value:9)
                        }
                        }
                    }
                        }
                    }
                }.padding(.leading, 15)
                .disabled(compose.done)
            }
        }.padding(5)
    }
    
    func add() {
        empty = false
        //face.input(compose.value)
        scalar.add(compose.value)

       // print(compose.relatif)
        compose.reset()
    }

}


//
//  SwiftUIView.swift
//  
//
//  Created by Herve Crespel on 11/06/2023.
//

import SwiftUI

@available(macOS 11.0, *)
public struct ChiffreHexa: View {
    var index = 15
    var conf = Digiconfig(.horiz)
    
    public init (_ val:Int, _ config:Digiconfig) {
        index = val
        conf = config
    }
    
    var hexagram : Hexagramdata {
        Hexagramdata.byvalue(index)
    }

    public var body: some View {

        if conf.style == .alter {
            HStack(spacing:conf.size/20) {
                Barre(bin:hexagram.top.high, conf:conf)
                Barre(bin:hexagram.top.middle, conf:conf)
                Barre(bin:hexagram.top.low, conf:conf)
                
                Barre(bin:hexagram.bottom.high, conf:conf)
                Barre(bin:hexagram.bottom.middle, conf:conf)
                Barre(bin:hexagram.bottom.low, conf:conf)
            }
        } else {
            VStack(spacing:conf.size/20) {
                Barre(bin:hexagram.top.high, conf:conf)
                Barre(bin:hexagram.top.middle, conf:conf)
                Barre(bin:hexagram.top.low, conf:conf)
                
                Barre(bin:hexagram.bottom.high, conf:conf)
                Barre(bin:hexagram.bottom.middle, conf:conf)
                Barre(bin:hexagram.bottom.low, conf:conf)
            }
        }

        
    }
}

@available(macOS 11.0, *)
public struct NombreHexa: View {
    @State var chiffres = [0]
    @State var value = 0
    var conf = Digiconfig(.horiz)
    var edit = false
    
    public init(_ value:Int, _ config:Digiconfig,_ edit:Bool = false, _ base:Int = 64) {
        conf = config
        var tab : [Int] = []
        var mant = value
        while mant > 0 {
            let chiffre = mant % base
            tab.append(chiffre)
            mant = (mant - chiffre) / base
        }
        chiffres = tab.reversed()
        self.value = value
        self.edit = edit
    }
    
    public var body: some View {
        VStack {
            HStack {
                ForEach(0..<chiffres.count, id: \.self) {
                    i in
                    VStack {
                        if edit {
                            Button(action : {inc(i)}) {
                                Image(systemName: "chevron.up")
                            }.padding(.bottom,15)
                        }
                        Group{
                            if conf.style == .alter && i % 2 == 0 {
                                ChiffreHexa(chiffres[i], Digiconfig(conf))
                            } else {
                                ChiffreHexa(chiffres[i], conf)
                            }
                        }.padding(2)
                        .background(conf.fond)
                        if edit {
                            Text("\(chiffres[i])")
                            Button(action : {dec(i)}) {
                                Image(systemName: "chevron.down")
                            }.padding(.top,15)
                        }
                        
                    }
                }
            }
            Text("\(value)").font(.title).padding(20)
        }
    }
    
    func inc(_ i:Int) {
        if chiffres[i] == conf.base - 1 {
            chiffres[i] = 0
            if i == 0 {
                var new = [1]
                for n in 0..<chiffres.count {
                    new.append(chiffres[n])
                }
                chiffres = new
            } else {
                inc(i-1)
            }
        } else {
            chiffres[i] += 1
        }
        setvalue()
    }
    func dec(_ i:Int) {
        if i == 0 && chiffres[0] == 1 {
            if chiffres.count > 0 {
                var new :[Int] = []
                for p in 1..<chiffres.count {
                    new.append(chiffres[p])
                }
                chiffres = new
            }
        }
        if chiffres[i] == 0 {
            chiffres[i] = conf.base - 1
            if i > 0 {
                dec(i-1)
            }
        } else {
            chiffres[i] -= 1
        }

        setvalue()
    }
    
    func setvalue() {
        let nbc = chiffres.count
        switch nbc {
        case 0:
            value = 0
        case 1:
            value = chiffres[0]
        case 2:
            value = chiffres[0] * conf.base + chiffres[1]
        default:
            var mant = chiffres[0]
            for p in 1..<nbc-1 {
                mant = mant * conf.base + chiffres[p]
            }
            value = mant + chiffres[nbc-1]
        }
    }
    
  /*  func yins(_ i:Int)->[Int]{
        var tabint : [Int] = []
        var reduce : Int = chiffres[i]
        for _ in 0...5 {
            let yin = reduce%2
            tabint.append(yin)
            reduce = (reduce - yin)/2
        }
        return tabint.reversed()
    }*/
}

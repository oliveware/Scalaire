//
//  HexagramdataEditor.swift
//  hexagram
//
//  Created by Herve Crespel on 19/06/2021.
//

import SwiftUI

@available(macOS 11.0, *)
public struct HexaNavigator: View {
    @State public var index = 35
    @State public var top = 2
    @State public var bottom = 7
    @State public var config = Digiconfig(.yijing)
    
    // public initialiser mandatory for any view inside a package
    public init(index:Int, top:Int, bottom:Int) {
        self.index = index
        self.top = top
        self.bottom = bottom
    }
    public init() {
        
    }
    
    public var hexagram: some View {
       HStack(spacing:10) {
           VStack(spacing:50) {
               Button(action: inc, label: {
                   Image(systemName: "chevron.up")
               })
               Button(action:dec, label: {
                   Image(systemName: "chevron.down")
               })
           }
           
           Hexagram(hexagram: Hexaglyphes.hexagrams[index])
               .frame(width: 540)
           
            VStack(spacing:50) {
                Button(action: next, label: {
                    Image(systemName: "plus")
                })
                Button(action: prev, label: {
                    Image(systemName: "minus")
                })
            }
        }
        
    }
    
    func inc(){
        index = index == 63 ? 0 : index + 1
        triset()
    }
    func dec() {
        index = index == 0 ? 63 : index - 1
        triset()
    }
    
    func next() {
        let val = Hexaglyphes.hexagrams[index].value
        index = Hexagramdata.lookup(val == 63 ? 0 : val + 1)
        triset()
    }
    func prev() {
        let val = Hexaglyphes.hexagrams[index].value
        index = Hexagramdata.lookup(val == 0 ? 63 : val - 1)
        triset()
    }
    func triset() {
        let value = Hexaglyphes.hexagrams[index].value
        bottom = value % 8
        top = (value - bottom) / 8
    }
    
   public var body: some View {
        VStack(alignment: .trailing) {
               
                HStack(alignment:.top, spacing:15) {
                    Button(action: toprev) {
                            Image(systemName: "chevron.backward")
                        }
                    Trigram(data:Hexaglyphes.trigrams[top], config:config)
                       
                    Button(action: topnext) {
                            Image(systemName: "chevron.forward")
                        }
                    }.padding(.trailing,12)
                
                hexagram

                HStack(alignment:.bottom, spacing:15) {
                    Button(action: botprev) {
                        Image(systemName: "chevron.backward")
                    }
                    Trigram(data:Hexaglyphes.trigrams[bottom], config:config)
                       
                    Button(action: botnext) {
                        Image(systemName: "chevron.forward")
                    }
                }.padding(.trailing,12)
                
            }.frame(width: 650)
            .padding(10)
            
            
         
        
    }
    
    func topnext(){
        top += 1
        if top == 8 {
            top=0
            bottom=0
        }
        hexaset()
    }
    func toprev(){
        top -= 1
        if top == -1 {top=7}
        hexaset()
    }
    func botnext(){
        bottom += 1
        if bottom == 8 {
            bottom=0
            topnext()
        }
        hexaset()
    }
    func botprev(){
        bottom -= 1
        if bottom == -1 {
            bottom=7
            toprev()
        }
        hexaset()
    }
    func hexaset() {
        index = Hexagramdata.lookup(top * 8 + bottom)
    }
    
}


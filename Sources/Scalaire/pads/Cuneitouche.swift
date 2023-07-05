//
//  Cuneitouche.swift
//  multikalk
//
//  Created by Herve Crespel on 22/11/2021.
//

import SwiftUI

struct Cunei: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    var width : CGFloat = 60
    var height : CGFloat = 40
  
    func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
            .frame(width: width, height: height)
            .font(.title)
            .padding(2)
            .foregroundColor(configuration.isPressed ? Color.yellow : .green)
            .background(isEnabled ? Color.blue : .gray)
            .cornerRadius(8)
  }
}

struct Cuneitouche: View {

    @Binding var compose : Compose
    
    var value = 9
    
    var body: some View {
        Button( action: { compose.add(value) } ) {
            if value > 9 {
                Text(compose.tens[value/10])
            } else {
                Text(compose.units[value])
            }
        }.disabled(compose.done)
        .buttonStyle(Cunei())

    }
    

}


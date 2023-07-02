//
//  Boule.swift
//  multikalk
//
//  Created by Herve Crespel on 22/11/2021.
//

import SwiftUI

struct Boule: View {
    var color = Color.yellow
    var width = 30.0
    var height = 20.0
    
    var body: some View {
        Ellipse().fill(color)
            .frame(width: width, height: height)
    }

}


//
//  NavBarView.swift
//  Modular
//
//  Created by Max Ward on 30/10/2023.
//

import SwiftUI

struct NavBarView: View {
    
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                action()
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            })
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
    }
}

//
//  AccountScreen.swift
//  Modular
//
//  Created by Max Ward on 28/10/2023.
//

import SwiftUI
import SwiftAuthProxy

struct SettingsRowView<Content: View>: View {
    
    let imageName: String
    let title: String
    let tintColor: Color
    @ViewBuilder var content: Content
    
    init(imageName: String, title: String, tintColor: Color, content: @escaping () -> Content) {
        self.imageName = imageName
        self.title = title
        self.tintColor = tintColor
        self.content = content()
    }
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.black)
            Spacer()
            content
        }
    }
}

struct AccountScreen: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("MW")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                    .mask(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Max Ward")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text("max.ward@gmail.com")
                            .font(.footnote)
                            .tint(.gray)
                    }
                }
            }
            
            Section("General") {
                SettingsRowView(imageName: "gear",
                                title: "Version",
                                tintColor: Color(.systemGray)) {
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                }
            }
            
            Section("Account") {
                Button(action: {
                    try? AuthenticationManager.destroySession()
                }, label: {
                    SettingsRowView(imageName: "arrow.left.circle.fill",
                                    title: "Sign Out",
                                    tintColor: .red,
                                    content: {EmptyView()})
                })
                
                Button(action: {}, label: {
                    SettingsRowView(imageName: "xmark.circle.fill",
                                    title: "Delete Account",
                                    tintColor: .red,
                                    content: {EmptyView()})
                })
            }
        }
    }
}

#Preview {
    AccountScreen()
}

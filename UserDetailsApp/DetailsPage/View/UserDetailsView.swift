//
//  UserDetailsView.swift
//  UserDetailsApp
//
//  Created by Ritik Sharma on 26/10/23.
//

import SwiftUI

struct UserDetailsView: View {
    
    var model: UserData.User
    
    var body: some View {
        VStack {
            VStack {
                AsyncImage(url: URL(string: self.model.avatar ?? "")) { image in
                    if let img = image.image {
                        img
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    }
                }
                
                HStack {
                    Text(self.model.firstName ?? "")
                        .font(.title)
                        .lineLimit(1)
                    
                    Text(self.model.lastName ?? "")
                        .font(.title)
                        .lineLimit(1)
                }
                Text(self.model.email ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
        }
        .navigationTitle(self.model.firstName ?? "User Details")
        .padding(16)
        .border(Color.gray, width: 1)
        .background(LinearGradient(colors: [.blue.opacity(0.2), .white, .blue.opacity(0.2)], startPoint: .top, endPoint: .bottom))
    }
}


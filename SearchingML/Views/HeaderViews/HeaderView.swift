//
//  HeaderView.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import SwiftUI

struct HeaderView: View {
    
    @State var text = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundStyle(Color.yellow)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.35)
            
            SearchView(text: $text)
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .padding(.top, 0)
    }
}

#Preview {
    HeaderView()
}

struct SearchView: View {
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    TextField("searchML", text: $text)
                        .padding(.trailing, 75)
                }
                .padding()
                .background(Color.white)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.text = ""
                    })
                    {
                       Text("cancel")
                    }.foregroundStyle(Color.black)
                }.padding()
            }.padding()
        }
    }
}

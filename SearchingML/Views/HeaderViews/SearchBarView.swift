//
//  SearchView.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text: String
    @Binding var isList: Bool
    var data : [String]
    @StateObject var vm = SearchViewVM()
    
    @State var isItemSelected = false
    @State var currentSelection = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                ZStack {
                    HStack {
                        TextField("searchML", text: $text)
                            .onChange(of: text) {
                                self.isItemSelected = true
                            }
                            .padding(.trailing, 75)
                    }
                    .padding()
                    .background(Color.white)
                    
                    if !self.text.isEmpty {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.text = ""
                                self.currentSelection = ""
                                self.isItemSelected = false
                            })
                            {
                                Text("cancel")
                            }.foregroundStyle(Color.black)
                        }.padding()
                    }
                }
                .cornerRadius(10)
                
                Button(action: {
                    self.isList.toggle()
                })
                {
                    VStack {
                        Image(systemName: isList ? "list.bullet" : "square.grid.2x2")
                            .padding()
                    }
                    .background(Color.yellow)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
                .foregroundStyle(Color.blue)
                .frame(width: 30, height: 30)
            }
            .padding(.horizontal, 8)
            
            if !self.text.isEmpty {
                if !isItemSelected  || currentSelection != self.text {
                    List(self.data.filter{$0.lowercased().contains(self.text.lowercased())}, id: \.self) { i in
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text("\(i)")
                                .foregroundStyle(Color.black)
                        }
                        .onTapGesture {
                            print(i)
                            self.text = i
                            self.currentSelection = i
                            self.isItemSelected = false
                        }
                    }
                    .cornerRadius(10)
                    .frame(height: 500)
                    .foregroundStyle(Color.clear)
                }
            }
        }
        .padding()
    }
}


#Preview {
    SearchBarView(text: Binding(get: { return "" }, set: { _ in }), isList: Binding(get: {return true}, set: { _ in }), data: [""])
}

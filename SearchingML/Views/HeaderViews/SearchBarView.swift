//
//  SearchView.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @ObservedObject var vm: SearchViewVM
    @Binding var text: String
    @Binding var isList: Bool
    @Binding var showDetailPage: Bool
    
    @State var isItemSelected = false
    @State var currentSelection = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                ZStack {
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                        
                        TextField("searchML", text: $text)
                            .onChange(of: text) {
                                self.isItemSelected = true
                            }
                            .padding(.trailing, 75)
                    }
                    .padding()
                    .background(Color.white)
                    .onSubmit {
                        vm.searchProduct(text: text)
                        self.showDetailPage = false
                    }
                    
                    if !self.text.isEmpty {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.text = ""
                                self.currentSelection = ""
                                self.isItemSelected = false
                            })
                            {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color.gray)
                                    .padding(.trailing, 10)
                                    .frame(width: 20, height: 20, alignment: .center)
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
        }
        .padding()
    }
}


#Preview {
    SearchBarView(vm: SearchViewVM(), text: Binding(get: { return "" }, set: { _ in }), isList: Binding(get: {return true}, set: { _ in }), showDetailPage: Binding(get: {return true}, set: { _ in }))
}

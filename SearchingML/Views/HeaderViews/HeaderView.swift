//
//  HeaderView.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import SwiftUI

struct HeaderView: View {
    
    @ObservedObject var vm: SearchViewVM
    @Binding var text: String
    @Binding var isList: Bool
    @Binding var showDetailPage: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color.yellow)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.20)
                .padding(.top, -50)
            
            SearchBarView(vm: vm, text: $text, isList: $isList, showDetailPage: $showDetailPage)
                .padding(.top, 8)
        }
    }
}

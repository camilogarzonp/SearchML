//
//  SearchView.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 5/09/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var vm = SearchViewVM()
    @State var text = ""
    @State var isList = true
    @State var showDetailPage: Bool = false
    
    var body: some View {
        VStack(spacing: 0){
            HeaderView(vm: vm, text: $text, isList: $isList, showDetailPage: $showDetailPage)
                .padding(.top)
            
            if !showDetailPage {
                CategorySegmentedView(vm: vm)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(.move(edge: .top))
                    .animation(.easeInOut, value: showDetailPage)
            }
            
            if vm.showProgress {
                ProgressView()
                    .frame(width: 100, height: 100)
            } else {
                if vm.products == nil {
                    Text("hereShowProducts")
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                        .padding([.horizontal, .top], 30)
                        .multilineTextAlignment(.center)
                } else {
                    FoundItemsView(vm: vm, isList: $isList, showDetailPage: $showDetailPage)
                }
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SearchView()
}

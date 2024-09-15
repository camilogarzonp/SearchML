//
//  BodyContentView.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 15/09/24.
//

import SwiftUI

struct BodyContentView: View {
    @ObservedObject var vm: SearchViewVM
    @Binding var isList: Bool
    @Binding var showDetailPage: Bool

    var body: some View {
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
    }
}

#Preview {
    BodyContentView(vm: SearchViewVM(), isList: Binding(get: { return false }, set: { _ in }), showDetailPage: Binding(get: { return false }, set: { _ in }))
}

//
//  CategorySegmentedView.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 7/09/24.
//

import SwiftUI

struct CategorySegmentedView: View {
    
    @ObservedObject var vm: SearchViewVM
    
    var body: some View {
        if let categories = vm.categories {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(categories) { category in
                        Button(action:{
                            withAnimation(.snappy) {
                                if vm.currentCategory != category {
                                    vm.currentCategory = category
                                    vm.searchCategory(categoryID: category.id)
                                } else {
                                    vm.currentCategory = nil
                                }
                            }
                        }) {
                            Text(category.name)
                                .font(.callout)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15)
                                .foregroundStyle(category == vm.currentCategory ? Color.white : Color.blue)
                                .background {
                                    if category == vm.currentCategory {
                                        Capsule()
                                            .fill(.blue)
                                    } else {
                                        Capsule()
                                            .fill(.yellow)
                                    }
                                }
                        }
                        
                    }
                }
            }
            .padding(8)
            .frame(height: 50)
        }
    }
}

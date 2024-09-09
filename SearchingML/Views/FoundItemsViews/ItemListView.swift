//
//  ItemListView.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 6/09/24.
//

import SwiftUI

struct ItemListView: View {
    
    var product: Item
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            AsyncImage(url: URL(string: product.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 120)
                        .cornerRadius(10)
                } else if phase.error != nil {
                    Text("noPhoto")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding(4)
                        .frame(width: 100, height: 120)
                        .cornerRadius(10)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2)))
                } else {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
            
            descriptionItemListView(product: product)
            
            Spacer()
        }
        .padding(8)
        .frame(width: UIScreen.main.bounds.width - 40)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 4)
    }
}


struct descriptionItemListView: View {
    
    let product: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(product.title)")
                .font(.subheadline)
                .lineLimit(2)
            
            if let originalPrice = product.originalPrice {
                HStack {
                    Text("$\(originalPrice.removeTrailingZeros())")
                        .strikethrough()
                        .font(.subheadline)
                        .lineLimit(2)
                        .foregroundStyle(Color.gray)
                    
                    Spacer()
                    
                    Text("\(originalPrice.discountRate(finalPrice: product.price).removeTrailingZeros())%")
                        .bold()
                        .foregroundStyle(Color.green)
                }
            }
            
            Text("$\(product.price.removeTrailingZeros())")
                .font(.title)
                .bold()
            
            if let shipping = product.shipping , shipping.freeShipping ?? false {
                Text("freeDelivery")
                    .bold()
                    .foregroundStyle(Color.green)
            }
        }
    }
}

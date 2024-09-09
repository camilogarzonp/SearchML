//
//  ItemGridView.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 6/09/24.
//

import SwiftUI

struct ItemGridView: View {
    
    let product: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: product.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 35, height: 160)
                        .cornerRadius(10)
                } else if phase.error != nil {
                    Text("noPhoto")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 35, height: 160)
                        .cornerRadius(10)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2)))
                } else {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
            
            descriptionItemGridView(product: product)
            
            Spacer(minLength: 0)
        }
        .padding(10)
        .frame(width: (UIScreen.main.bounds.width / 2) - 25)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 4)
    }
}

struct descriptionItemGridView: View {
    
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
                        .font(.caption)
                        .lineLimit(2)
                        .foregroundStyle(Color.gray)
                    
                    Spacer()
                    
                    Text("\(originalPrice.discountRate(finalPrice: product.price).removeTrailingZeros())%")
                        .bold()
                        .font(.caption)
                        .foregroundStyle(Color.green)
                }
            }
            
            Text("$\(product.price.removeTrailingZeros())")
                .font(.title2)
                .bold()
            
            if let shipping = product.shipping , shipping.freeShipping ?? false {
                Text("freeDelivery")
                    .bold()
                    .foregroundStyle(Color.green)
            }
        }
        .padding(10)
    }
}

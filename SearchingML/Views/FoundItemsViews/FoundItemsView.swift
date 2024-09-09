//
//  FoundItemsView.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import SwiftUI

struct FoundItemsView: View {
    
    @ObservedObject var vm: SearchViewVM
    
    @Binding var isList: Bool
    @Binding var showDetailPage: Bool
    
    @State var currentProduct: Item? = nil
    @State var isShowingPurchaseConfirmation: Bool = false
    @State private var isProcessing = false
    @State private var progressValue: Float = 0.0
    
    // Matched Geometry Effect
    @Namespace var animation
    
    // MARK: Detail Animation Properties
    @State var animationView: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            if let products = vm.products {
                if isList {
                    List(products, id: \.self) { product in
                        Button {
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                self.currentProduct = product
                                self.showDetailPage = true
                            }
                        } label: {
                            ItemListView(product: product)
                        }
                        .buttonStyle(ScaledButtonStyle())
                    }
                    .listStyle(PlainListStyle())
                    .padding(5)
                    .opacity(showDetailPage ?  0 : 1)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(products, id: \.self) { product in
                                Button {
                                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                        self.currentProduct = product
                                        self.showDetailPage = true
                                    }
                                } label: {
                                    ItemGridView(product: product)
                                }
                                .buttonStyle(ScaledButtonStyle())
                            }
                        }
                        .padding()
                        .opacity(showDetailPage ?  0 : 1)
                    }
                }
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .edgesIgnoringSafeArea(.all)
        .overlay {
            if let currentProduct = currentProduct, showDetailPage {
                DetailView(product: currentProduct)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
        .background(alignment: .top) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .frame(height: animationView ? nil : 350, alignment: .top)
                .opacity(animationView ? 1 : 0)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func CardView(product: Item) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            ZStack(alignment: .topLeading) {
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    AsyncImage(url: URL(string: product.thumbnail)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width, height: size.height)
                                .cornerRadius(10)
                        } else if phase.error != nil {
                            Color.gray.opacity(0.15)
                                .frame(width: size.width, height: size.height)
                                .cornerRadius(10)
                        } else {
                            ProgressView()
                                .frame(width: 100, height: 100)
                        }
                    }
                    
                }
                .frame(height: 300)
            }
            
            Text(product.title)
                .font(.title3.bold())
            
            VStack(alignment: .leading, spacing: 0) {
                if let originalPrice = product.originalPrice {
                    Text("$\(originalPrice.removeTrailingZeros())")
                        .foregroundStyle(Color.gray)
                        .strikethrough()
                        .font(.body)
                }
                
                HStack(spacing: 15) {
                    Text("$\(product.price.removeTrailingZeros())")
                        .font(.title.bold())
                    
                    if let originalPrice = product.originalPrice {
                        Text("\(originalPrice.discountRate(finalPrice: product.price).removeTrailingZeros())% OFF")
                            .bold()
                            .foregroundStyle(Color.green)
                    }
                }
                
                if let installments = product.installments {
                    Text(String(format: NSLocalizedString("installments", comment: ""), installments.quantity, installments.amount))
                    
                }
                
                if product.availableQuantity == 1 {
                    Text("lastUnit")
                        .bold()
                } else {
                    Text(String(format: NSLocalizedString("availableQuantity", comment: ""), product.availableQuantity))
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                if let seller = product.seller {
                    HStack {
                        Text("seller")
                        
                        Text(product.seller?.nickname ?? "")
                            .foregroundStyle(Color.blue)
                    }
                    
                    if let powerSellerStatus = seller.powerSellerStatus {
                        Text(String(format: NSLocalizedString("sellerStatus", comment: ""), powerSellerStatus))
                    }
                }
                
                Text(String(format: NSLocalizedString("condition", comment: ""), product.condition))
            }
            
            VStack(spacing: 5) {
                if isProcessing {
                    VStack(spacing: 0) {
                        ProgressView(value: progressValue, total: 100)
                            .progressViewStyle(LinearProgressViewStyle())
                        
                        Text("Procesando compra...")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                    }
                    .padding()
                } else {
                    Button(action: {
                        startTransaction()
                    })
                    {
                        Text("buyNow")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue))
                    }
                }
                
                Button(action: {})
                {
                    Text("addToCart")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue.opacity(0.2)))
                }
            }
        }
        .padding()
        .background(Color.white)
        .matchedGeometryEffect(id: product.id, in: animation)
        .alert(isPresented: $isShowingPurchaseConfirmation) {
            Alert(
                title: Text("successfulPurchase"),
                message: Text(String(format: NSLocalizedString("successfulPurchase.message", comment: ""), product.title, product.price)),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func DetailView(product: Item) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CardView(product: product)
                    .scaleEffect(animationView ? 1 : 0.93)
            }
        }
        .overlay(alignment: .topTrailing, content: {
            Button {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animationView = false
                }
                
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)) {
                    currentProduct = nil
                    showDetailPage = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.yellow)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 2)
            }
            .padding()
            .opacity(animationView ? 1 : 0)
        })
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.1)) {
                animationView = true
            }
        }
        .transition(.identity)
    }
    
    func startTransaction() {
        isProcessing = true
        progressValue = 0.0
        
        // Simula la progresión con un temporizador
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.progressValue < 100 {
                self.progressValue += 5
            } else {
                timer.invalidate()
                self.isProcessing = false
                self.isShowingPurchaseConfirmation = true
            }
        }
    }
}

#Preview {
    FoundItemsView(vm: SearchViewVM(), isList: Binding(get: { return true }, set: { _ in  }), showDetailPage: Binding(get: { return true }, set: { _ in  }))
}

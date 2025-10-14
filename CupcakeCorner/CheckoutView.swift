//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 11/10/2025.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    var body: some View {
        ScrollView {
            VStack {
                // we could store following image in the app itself, but having a remote image means we can dynamically switch it out for seasonal alternatives and promotions.
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { downloadedImage in
                    downloadedImage
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 230)
                
                OrderSummaryTableView(order: order)
                
                Text("Your total is \(order.totalCost, format: .currency(code: "USD"))")
                    .font(.title2.bold())
                    .padding(.top)
                
                Button("Place Order", action: {})
                    .padding()
                    .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Check Out")
            .toolbarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize) // Using scroll views is a great way to make sure your layouts work great no matter what Dynamic Type size the user has enabled, but it creates a small annoyance: when your views fit just fine on a single screen, they still bounce a little when the user moves up and down on them.  The scrollBounceBehavior() modifier helps us disable that bounce when there is nothing to scroll. With that in place we'll get nice scroll bouncing when we have actually scrolling content, otherwise the scroll view acts like it isn't even there.
        }
    }
}

struct OrderSummaryTableView: View {
    var order: Order
    
    struct Row: View {
        let header: String
        let value: String
        
        var body: some View {
            HStack(spacing: 0) {
                Text(header)
                    .fontWeight(.semibold)
                    .padding(12)
                    .frame(width: 120, alignment: .leading)
                    .border(.secondary, width: 0.2)
                    .background(.secondary.opacity(0.1))
                Text(value)
                    .padding(12)
                    .frame(width: 250, alignment: .leading)
                    .border(.secondary, width: 0.2)
            }
            .font(.subheadline)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order Details")
                .padding(.top)
                .fontWeight(.semibold)
            VStack(spacing: 0) {
                Row(header: "Type", value: Order.allTypes[order.type])
                Row(header: "Quantity", value: String(order.quantity))
                
                if order.extraFrosting {
                    Row(header: "Frosting", value: "Yes")
                }
                
                if order.addSprinkles {
                    Row(header: "Sprinkles", value: "Yes")
                }
            }
            
            Text("Delivery Details")
                .padding(.top)
                .fontWeight(.semibold)
            VStack(spacing: 0) {
                Row(header: "Name", value: order.name)
                Row(header: "Street", value: order.streetAddress)
                Row(header: "City", value: order.city)
                Row(header: "Zip", value: order.zip)
            }
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}

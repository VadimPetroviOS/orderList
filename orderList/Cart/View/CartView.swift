//
//  CartView.swift
//  orderList
//
//  Created by Вадим on 11.08.2024.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        List(0..<viewModel.items.count, id: \.self) { index in
            HStack {
                Image(viewModel.items[index].image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 144, height: 144)
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(viewModel.items[index].name)
                        Spacer()
                    }
                        
                    HStack {
                        Text(viewModel.items[index].price)
                        Text("\(viewModel.items[index].quantity)")
                    }
                }
                .font(.body)
                .frame(width: 199, height: 144)
            }
        }
    }
}

#Preview {
    CartView()
        .environmentObject(MainViewModel())
}

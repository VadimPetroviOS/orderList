//
//  Counter.swift
//
//
//  Created by Вадим on 10.08.2024.
//

import SwiftUI

public struct DataCounter: View {
    
    @State
    private var selectedUnit = 0
    
    @State
    private var quantity: Int = 1
    
    let price: Double
    let onApply: (String, String) -> Void
    
    public init(_ price: Double, onApply: @escaping (String, String) -> Void) {
            self.price = price
            self.onApply = onApply
        }
    
    public var body: some View {
        VStack(spacing: 0) {
            pickerView
            backgroundView
        }
    }
    
    private var pickerView: some View {
        Picker("", selection: $selectedUnit) {
            Text("Шт").tag(0)
            Text("Кг").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(height: 28)
        .padding(.horizontal, 5)
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(.green)
            .frame(height: 36)
            .padding(4)
            .overlay(
                HStack {
                    minusQuantityButton
                    Spacer()
                    applyQuantityButton
                    Spacer()
                    plusQuantityButton
                }
                    .buttonStyle(PlainButtonStyle())
            )
    }
    
    private var minusQuantityButton: some View {
        Button {
            if quantity > 1 {
                quantity -= 1
            }
        } label: {
            Image(systemName: "minus")
                .foregroundStyle(.white)
                .contentShape(Rectangle())
        }
        .padding()
    }
    
    private var applyQuantityButton: some View {
        let quantityText = selectedUnit == 0 ? "\(quantity) шт" : String(format: "%.1f кг", 0.1 * Double(quantity))
        let priceText = selectedUnit == 0 ? String(format: "%.2f ₽", Double(quantity) * price) : String(format: "%.2f ₽", Double(quantity) * price / 10)
        return Button {
            onApply(quantityText, priceText)
        } label: {
            VStack(spacing: 0) {
                Text(quantityText)
                    .font(.body)
                    .bold()
                
                Text(priceText)
                .font(.footnote)
                .minimumScaleFactor(0.5)
            }
            .foregroundColor(.white)
            .padding(2)
        }
    }
    
    private var plusQuantityButton: some View {
        Button {
            quantity += 1
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.white)
        }
        .padding()
    }
}

#Preview {
    DataCounter(990.90) { price, quantity in }
}

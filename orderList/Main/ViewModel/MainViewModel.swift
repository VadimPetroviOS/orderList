//
//  MainViewModel.swift
//  orderList
//
//  Created by Вадим on 11.08.2024.
//

import Foundation
import SwiftUI

final class MainViewModel: MainViewModelProtocol {
    @Published
    var favoriteStates: [Int: Bool] = [:]
    @Published
    private(set) var products: [MainData] = []
    
    private(set) var items: [CartItem] = []
    
    private let networkingModel: MainModelProtocol
    
    init(networkingModel: MainModelProtocol = MockMainModel()) {
        self.networkingModel = networkingModel
    }
    
    func loadGridData() {
        Task {
            let fetchedProducts = try await networkingModel.fetchGridData()
            await MainActor.run {
                self.products = fetchedProducts
            }
        }
    }
    
    func loadListData() {
        Task {
            let fetchedProducts = try await networkingModel.fetchListData()
            await MainActor.run {
                self.products = fetchedProducts
            }
        }
    }
    
    func getBadgeColor(_ badgeName: String) -> Color {
        switch badgeName {
        case "Удар по ценам":
            return Color.customRedColor
        case "Новинки":
            return Color.customBlueColor
        default:
            return Color.customGreenColor
        }
    }
    
    func getCountryIcon(_ country: String) -> String {
        switch country {
        case "Франция":
            return "🇫🇷"
        default:
            return ""
        }
    }
    
    func editPrice(_ price: Double) -> (String, String) {
        let numberString = String(format: "%.2f", price)
        let components = numberString.split(separator: ".")
        if let integerPart = components.first, let fractionalPart = components.last {
            let integerString = String(integerPart)
            let fractionalString = String(fractionalPart)
            return (integerString, fractionalString)
        }
        return ("", "")
    }
    
    func toggleFavorite(for index: Int) {
        if favoriteStates[index] == nil {
            favoriteStates[index] = false
        }
        
        favoriteStates[index]?.toggle()
    }
    
    func isFavorite(at index: Int) -> Bool {
        return favoriteStates[index] ?? false
    }
    
    func addToCart(image: String, name: String, price: String, quantity: String) {
        let item = CartItem(
            image: image,
            name: name,
            price: price,
            quantity: quantity
        )
        items.append(item)
    }
}

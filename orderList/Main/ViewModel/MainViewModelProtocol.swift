//
//  MainViewModelProtocol.swift
//  orderList
//
//  Created by Вадим on 11.08.2024.
//

import Foundation
import SwiftUI

protocol MainViewModelProtocol: ObservableObject {
    var products: [MainData] { get }
    var items: [CartItem] { get }
    func getBadgeColor(_ badgeName: String) -> Color
    func getCountryIcon(_ country: String) -> String
    func editPrice(_ price: Double) -> (String, String)
    func toggleFavorite(for index: Int)
    func isFavorite(at index: Int) -> Bool
    func loadGridData()
    func loadListData()
    func addToCart(image: String, name: String, price: String, quantity: String)
}

//
//  MainModel.swift
//  orderList
//
//  Created by Вадим on 11.08.2024.
//

import Foundation

protocol MainModelProtocol {
    func fetchGridData() async throws -> [MainData]
    func fetchListData() async throws -> [MainData]
}

final class MockMainModel: MainModelProtocol {
    func fetchGridData() async throws -> [MainData] {
        return [
            MainData(
                image: "image1",
                badgeName: "Удар по ценам",
                rate: "4.1",
                sale: nil,
                name: "сыр Ламбер 500/0 230г",
                country: "Франция",
                price: 99.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image2",
                badgeName: nil,
                rate: "4.1",
                sale: nil,
                name: "Энергетический Напиток",
                country: nil,
                price: 95699.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image3",
                badgeName: nil,
                rate: "4.1",
                sale: nil,
                name: "Салат Овощной с Крабовыми Палочками",
                country: nil,
                price: 250.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image4",
                badgeName: nil,
                rate: "4.1",
                sale: "25%",
                name: "Дорадо Охлажденная Непотрошеная 300-400г",
                country: nil,
                price: 59.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image5",
                badgeName: "Новинки",
                rate: "4.1",
                sale: nil,
                name: "Ролл Маленькая Япония 216г",
                country: nil,
                price: 367.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image6",
                badgeName: "Цена по карте",
                rate: "4.1",
                sale: nil,
                name: "Огурцы тепличные cадово-огородные",
                country: "Франция",
                price: 59.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image7",
                badgeName: "Новинки",
                rate: "4.1",
                sale: "25%",
                name: "Манго Кео",
                country: nil,
                price: 1298.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image8",
                badgeName: nil,
                rate: "4.1",
                sale: nil,
                name: "Салат Овощной с Крабовыми Палочками",
                country: nil,
                price: 120.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image9",
                badgeName: nil,
                rate: "4.1",
                sale: nil,
                name: "Салат Овощной с Крабовыми Палочками",
                country: nil,
                price: 1298.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image10",
                badgeName: "Удар по ценам",
                rate: "4.1",
                sale: nil,
                name: "Масло Слобода Рафинированное 1,8л",
                country: nil,
                price: 1298.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image11",
                badgeName: nil,
                rate: "4.1",
                sale: nil,
                name: "Салат Овощной с Крабовыми Палочками",
                country: nil,
                price: 250,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image12",
                badgeName: "Новинки",
                rate: "4.1",
                sale: nil,
                name: "Макаронные Изделия SPAR Спагетти 450г",
                country: nil,
                price: 2600.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image13",
                badgeName: nil,
                rate: "4.1",
                sale: nil,
                name: "Огурцы тепличные cадово-огородные",
                country: "Франция",
                price: 120.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
            MainData(
                image: "image14",
                badgeName: "Цена по карте",
                rate: "4.1",
                sale: nil,
                name: "Огурцы тепличные cадово-огородные",
                country: nil,
                price: 120.90,
                oldPrice: 199.0,
                reviewCount: nil
            ),
        ]
    }
    
    func fetchListData() async throws -> [MainData] {
        return [
            MainData(
                image: "image15",
                badgeName: "Удар по ценам",
                rate: "4.1",
                sale: "25%",
                name: "Огурцы тепличные cадово-огородные",
                country: nil,
                price: 59.90,
                oldPrice: 199.0,
                reviewCount: 19
            ),
            MainData(
                image: "image16",
                badgeName: "Новинки",
                rate: "4.1",
                sale: "25%",
                name: "Дорадо Охлажденная Непотрошеная 300-400г",
                country: "Франция",
                price: 120.90,
                oldPrice: 199.0,
                reviewCount: 19
            ),
            MainData(
                image: "image17",
                badgeName: nil,
                rate: "4.1",
                sale: nil,
                name: "Энергетический Напиток AdrenaIine Rush 0,449л ж/б",
                country: "Франция",
                price: 99.90,
                oldPrice: 199.0,
                reviewCount: 19
            ),
            MainData(
                image: "image18",
                badgeName: "Удар по ценам",
                rate: "4.1",
                sale: "25%",
                name: "Манго Кео",
                country: "Франция",
                price: 95699.90,
                oldPrice: 199.0,
                reviewCount: 19
            ),
            MainData(
                image: "image15",
                badgeName: nil,
                rate: "4.1",
                sale: "25%",
                name: "сыр Ламбер 500/0 230г",
                country: nil,
                price: 95699.90,
                oldPrice: 199.0,
                reviewCount: 19
            ),
            MainData(
                image: "image15",
                badgeName: nil,
                rate: "4.1",
                sale: "25%",
                name: "сыр Ламбер 500/0 230г",
                country: "Франция",
                price: 95699.90,
                oldPrice: 199.0,
                reviewCount: 19
            ),
            MainData(
                image: "image15",
                badgeName: nil,
                rate: "4.1",
                sale: "25%",
                name: "сыр Ламбер 500/0 230г",
                country: nil,
                price: 95699.90,
                oldPrice: 199.0,
                reviewCount: 19
            ),
            MainData(
                image: "image15",
                badgeName: nil,
                rate: "4.1",
                sale: "25%",
                name: "сыр Ламбер 500/0 230г",
                country: nil,
                price: 95699.90,
                oldPrice: 199.0,
                reviewCount: 19
            )
        ]
    }
}

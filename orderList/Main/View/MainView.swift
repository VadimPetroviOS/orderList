//
//  MainView.swift
//  orderList
//
//  Created by Вадим on 10.08.2024.
//

import SwiftUI
import Utils

struct MainView<ViewModel: MainViewModelProtocol>: View {
    @StateObject
    private var viewModel: ViewModel
    
    @State
    private var selectedItemIndex: Int? = nil
    
    @State
    private var isGridView = true
    
    init() where ViewModel == MainViewModel {
        _viewModel = StateObject(wrappedValue: MainViewModel())
    }
    
    var body: some View {
        NavigationStack {
            contentView
        }
    }
    
    private var contentView: some View {
        VStack {
            if isGridView {
                gridView
                    .onAppear {
                        viewModel.loadGridData()
                    }
            } else {
                listView
                    .onAppear {
                        viewModel.loadListData()
                    }
            }
        }
        .toolbar { toolbarContent }
    }
    
    private var gridView: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: Constants.columns) {
                ForEach(0..<viewModel.products.count, id: \.self) { index in
                    ZStack(alignment: .top) {
                        gridBackgroundView
                        gridProductView(for: index)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var gridBackgroundView: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.white)
            .frame(height: 278)
            .shadow(
                color: .black.opacity(0.2),
                radius: 4
            )
    }
    
    private func gridProductView(for index: Int) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            productGridImageView(for: index)
            productNameView(for: index)
                .lineLimit(selectedItemIndex == index ? 1:2)
                .padding(8)
            if selectedItemIndex == index {
                DataCounter(viewModel.products[index].price) { price, quantity in
                    viewModel.addToCart(
                        image: viewModel.products[index].image,
                        name: viewModel.products[index].name,
                        price: price,
                        quantity: quantity
                    )
                }
            } else {
                productCountryView(for: index)
                    .padding(
                        EdgeInsets(
                            top: -4,
                            leading: 8,
                            bottom: .zero,
                            trailing: .zero
                        )
                    )
                Spacer(minLength: .zero)
                productBuyView(for: index)
                    .padding(8)
            }
        }
    }
    
    private func productGridImageView(for index: Int) -> some View {
        Image(viewModel.products[index].image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(
                maxWidth: .infinity,
                maxHeight: 168
            )
            .overlay(
                VStack {
                    HStack(alignment: .top) {
                        badgeView(viewModel.products[index].badgeName)
                        Spacer()
                        actionListView(for: index)
                    }
                    Spacer()
                    HStack{
                        productRateView(for: index)
                            .padding(
                                EdgeInsets(
                                    top: .zero,
                                    leading: 6,
                                    bottom: 4,
                                    trailing: .zero
                                )
                            )
                        Spacer()
                        productDiscountView(for: index)
                    }
                    .font(.callout)
                },
                alignment: .top
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
    }
    
    private var listView: some View {
        List(0..<viewModel.products.count, id: \.self) { index in
            HStack(spacing: 0) {
                productListImageView(for: index)
                    .frame(width: 144, height: 144)
                productDetailsView(for: index)
                    .frame(width: 199, height: 144)
            }
        }
        .listStyle(.plain)
    }
    
    private func productListImageView(for index: Int) -> some View {
        Image(viewModel.products[index].image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .padding()
            .overlay(
                VStack {
                    HStack {
                        badgeView(viewModel.products[index].badgeName)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        productDiscountView(for: index)
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private func productDetailsView(for index: Int) -> some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 4) {
                    productRateView(for: index)
                        .padding(
                            EdgeInsets(
                                top: 2,
                                leading: 4,
                                bottom: 2,
                                trailing: .zero
                            )
                        )
                    Text("|")
                        .foregroundStyle(.black).opacity(0.6)
                        .padding(.bottom, 2)
                    Text("\(viewModel.products[index].reviewCount.map { "\($0) отзывов" } ?? "Нет отзывов")")
                        .foregroundStyle(.black).opacity(0.6)
                }
                .font(.footnote)
                productNameView(for: index)
                    .padding(
                        EdgeInsets(
                            top: 4,
                            leading: 8,
                            bottom: .zero,
                            trailing: .zero
                        )
                    )
                    .fixedSize(horizontal: false, vertical: true)
                if selectedItemIndex == index {
                    Spacer()
                    DataCounter(viewModel.products[index].price) { price, quantity in
                        viewModel.addToCart(
                            image: viewModel.products[index].image,
                            name: viewModel.products[index].name,
                            price: price,
                            quantity: quantity
                        )
                    }
                } else {
                    productCountryView(for: index)
                        .padding(
                            EdgeInsets(
                                top: 2,
                                leading: 8,
                                bottom: .zero,
                                trailing: .zero
                            )
                        )
                    Spacer()
                    productBuyView(for: index)
                        .padding(
                            EdgeInsets(
                                top: .zero,
                                leading: 8,
                                bottom: .zero,
                                trailing: .zero
                            )
                        )
                }
            }
            HStack {
                Spacer()
                VStack {
                    actionListView(for: index)
                    Spacer()
                }
            }
            
        }
    }
    
    @ViewBuilder
    private func badgeView(_ badgeName: String?) -> some View {
        if let badgeName = badgeName {
            Text(badgeName)
                .font(.caption2)
                .foregroundStyle(.white)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 12,
                        bottom: 0,
                        trailing: 6
                    )
                )
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(viewModel.getBadgeColor(badgeName))
                        .frame(height: 16)
                )
        }
    }
    
    private func productDiscountView(for index: Int) -> some View {
        Text(viewModel.products[index].sale ?? "")
            .font(.body)
            .bold()
            .foregroundStyle(Color.cherryColor)
            .padding(.trailing, 5)
    }
    
    private func productRateView(for index: Int) -> some View {
        HStack(spacing: 2) {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
                .bold()
            Text(viewModel.products[index].rate)
        }
        .font(.footnote)
    }
    
    private func productNameView(for index: Int) -> some View {
        Text(viewModel.products[index].name)
            .font(.system(size: 12))
            .foregroundStyle(.black.opacity(0.8))
    }
    
    private func actionListView(for index: Int) -> some View {
        Rectangle()
            .fill(.white)
            .opacity(0.8)
            .frame(width: 32, height: 64)
            .overlay(
                VStack {
                    Button {
                        
                    } label: {
                        Image("paper")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.black)
                        
                    }
                    
                    Spacer().frame(height: 8)
                    
                    Button {
                        viewModel.toggleFavorite(for: index)
                    } label: {
                        Image(systemName: viewModel.isFavorite(at: index) ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 13, height: 12)
                            .foregroundStyle(viewModel.isFavorite(at: index) ? .green : .gray)
                            .bold()
                    }
                }
            )
            .buttonStyle(PlainButtonStyle())
            .clipShape(RoundedCornerShape(corners: [.bottomLeft], radius: 16))
    }
    
    @ViewBuilder
    private func productCountryView(for index: Int) -> some View {
        if let country = viewModel.products[index].country {
            HStack {
                Text(country) + Text(" \(viewModel.getCountryIcon(country))")
            }
            .font(.footnote)
            .foregroundStyle(.black.opacity(0.6))
        }
    }
    
    private func productBuyView(for index: Int) -> some View {
        HStack {
            productPricesView(for: index)
                .fixedSize(horizontal: true, vertical: false)
            Spacer()
            cartView(for: index)
        }
    }
    
    private func productPricesView(for index: Int) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 2) {
                let (div, mod) = viewModel.editPrice(viewModel.products[index].price)
                Text(div)
                if mod != "00" {
                    Text(mod)
                        .font(.headline)
                }
                Image("PerAmountIcon")
                    .resizable()
                    .frame(
                        width: 20,
                        height: 20
                    )
            }
            .font(.title3)
            .bold()
            
            Text(String(describing:  viewModel.products[index].oldPrice))
                .font(.footnote)
                .strikethrough()
                .foregroundStyle(.black.opacity(0.6))
            
        }
    }
    
    private func cartView(for index: Int) -> some View {
        Button {
            selectedItemIndex = index
        } label: {
            Image("basket")
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.green)
                        .frame(width: 48, height: 36)
                )
        }
        .frame(width: 48, height: 36)
        .padding(4)
        .buttonStyle(PlainButtonStyle())
    }
    
    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    withAnimation {
                        selectedItemIndex = nil
                        isGridView.toggle()
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(uiColor: .systemGroupedBackground))
                            .frame(width: 40, height: 40)
                        Image(systemName: isGridView ? "square.grid.2x2" : "rectangle.grid.1x2")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundStyle(Color.customGreenColor)
                            .bold()
                    }
                    .padding(.bottom, 10)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    CartView()
                        .environmentObject(viewModel)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(uiColor: .systemGroupedBackground))
                            .frame(width: 40, height: 40)
                        Image("basket")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 18, height: 18)
                            .foregroundStyle(Color.customGreenColor)
                    }
                    .padding(.bottom, 10)
                }
            }
        }
    }
}

private enum Constants {
    static let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible()),
    ]
}

#Preview {
    MainView()
}

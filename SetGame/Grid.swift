//
//  Grid.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-01-27.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View{
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    var body: some View {
        GeometryReader { geometry in
            ForEach(items) { item in
                self.body(for: item, layout: GridLayout(itemCount: items.count, in: geometry.size))
            }
        }
    }
    
    private func body(for item: Item, layout: GridLayout) -> some View {
        let index = items.firsrIndexOf(matching: item)!
        return viewForItem(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: index))
        
    }
}

//
//  SetGameApp.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-01-27.
//

import SwiftUI

@main
struct SetGameApp: App {
    let viewModel = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: viewModel)
        }
    }
}

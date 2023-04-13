//
//  MemoryGameApp.swift
//  MemoryGame
//
//  Created by Lucas Martins Figueiredo on 24/03/23.
//

import SwiftUI

@main
struct MemoryGameApp: App {
    let game = MemoryGameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}

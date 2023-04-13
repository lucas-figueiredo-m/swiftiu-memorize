//
//  MemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Lucas Martins Figueiredo on 08/04/23.
//

import SwiftUI

class MemoryGameViewModel: ObservableObject {
    static var themeList: [MemoryGameModel<String>.Theme] = [
        MemoryGameModel<String>.Theme(name: "Cars", emojiSet: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍️", "🛺", "🚡", "🚠", "🚅", "🚈", "🚂"], numberOfPairs: 3, color: .red),
        MemoryGameModel<String>.Theme(name: "Fruits", emojiSet: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🥥", "🥝", "🍅", "🥑"], numberOfPairs: 4, color: .blue),
        MemoryGameModel<String>.Theme(name: "Flags", emojiSet: ["🇺🇳", "🇦🇫", "🇿🇦", "🇦🇱", "🇩🇪", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇸🇦", "🇩🇿", "🇦🇷", "🇦🇲", "🇮🇴", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇩", "🇧🇧", "🇧🇭", "🇧🇪", "🇧🇿", "🇧🇯", "🇧🇲", "🇧🇾", "🇧🇴", "🇧🇦", "🇧🇼", "🇧🇷"], numberOfPairs: 12, color: .green),
        MemoryGameModel<String>.Theme(name: "Faces", emojiSet: ["😁", "😇", "😂", "🤩", "😭", "😡", "😨", "🤡"], numberOfPairs: 10, color: .purple),
        MemoryGameModel<String>.Theme(name: "Sky", emojiSet: ["🪐", "🌞", "🌜", "🌎", "☄️", "🌈", "⛅️", "⛈️", "❄️"], numberOfPairs: 5, color: .black),
        MemoryGameModel<String>.Theme(name: "Animals", emojiSet: ["🐶", "🐭", "🐰", "🦊", "🐻", "🐼", "🐸", "🐵", "🦐", "🐳", "🐥", "🐨"], numberOfPairs: 8, color: .yellow),
    ]
    
    static func createInitialMemoryGame() -> MemoryGameModel<String> {
        MemoryGameModel<String>(numberOfPairsOfCards: 4) { pairIndex in
            themeList[0].emojiSet[pairIndex]
        }
    }
    
    func createMemoryGame(theme: MemoryGameModel<String>.Theme, numberOfPairsOfCards: Int) -> MemoryGameModel<String> {
        MemoryGameModel<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
            theme.emojiSet[pairIndex]
        }
    }
    
    @Published private var model: MemoryGameModel<String> = createInitialMemoryGame()
    @Published private var theme: MemoryGameModel<String>.Theme = themeList[0]
    
    init() {
        let theme = MemoryGameViewModel.themeList[0]
        let maximumNumberOfPairs = min(theme.numberOfPairs, theme.emojiSet.count)
        
        model = createMemoryGame(theme: theme, numberOfPairsOfCards: maximumNumberOfPairs)
    }
    
    var cards: Array<MemoryGameModel<String>.Card> {
        model.cards
    }
    
    var score: Int {
        0
    }
    
    var cardsTheme: MemoryGameModel<String>.Theme {
        theme
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        let randomThemeIndex = Int.random(in: MemoryGameViewModel.themeList.indices)
        let randomTheme = MemoryGameViewModel.themeList[randomThemeIndex]
        let maximumNumberOfPairs = min(randomTheme.numberOfPairs, randomTheme.emojiSet.count)
        
        model = createMemoryGame(theme: randomTheme, numberOfPairsOfCards: maximumNumberOfPairs)
        theme = randomTheme
    }
}

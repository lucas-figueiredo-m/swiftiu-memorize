//
//  ContentView.swift
//  MemoryGame
//
//  Created by Lucas Martins Figueiredo on 24/03/23.
//

import SwiftUI

struct ContentView: View {
    
    //    let carArray = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐"] //, "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍️", "🛺", "🚡", "🚠", "🚅", "🚈", "🚂"]
    //
    //    let foodArray = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶️", "🫑"]
    //
    //    let flagArray = ["🇺🇳", "🇦🇫", "🇿🇦", "🇦🇱", "🇩🇪", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇸🇦", "🇩🇿", "🇦🇷", "🇦🇲", "🇮🇴", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇩", "🇧🇧", "🇧🇭", "🇧🇪", "🇧🇿", "🇧🇯", "🇧🇲", "🇧🇾", "🇧🇴", "🇧🇦", "🇧🇼", "🇧🇷"]
    
    
    @ObservedObject var viewModel: MemoryGameViewModel
    
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.cardsTheme.name).font(.system(size: 40))
                Spacer()
                Text("Score: \(viewModel.score)").font(.system(size: 25))
            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
                    ForEach(viewModel.cards) { card in
                        MemoryCard(card: card)
                            .foregroundColor(viewModel.cardsTheme.color)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            
            Spacer()
            NewGame()
                .onTapGesture {
                    viewModel.startNewGame()
                }
        }
        .padding(.horizontal)
    }
}

struct TabIcon: View {
    var icon: String
    var label: String
    var body: some View {
        VStack{
            Image(systemName: icon)
                .font(.largeTitle)
            Text(label)
        }
    }
}

struct NewGame: View {
    
    var body: some View {
        HStack {
            Image(systemName: "shuffle")
                .font(.largeTitle)
                .foregroundColor(.blue)
            Text("New Game")
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue, lineWidth: 5)
        )
        
        
    }
}

struct MemoryCard: View {
    let card: MemoryGameModel<String>.Card
    
    var body: some View {
        let CardShape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            if card.isFaceUp {
                CardShape
                    .fill()
                    .foregroundColor(.white)
                CardShape
                    .strokeBorder(lineWidth: 3)
                
                Text(card.content)
                    .font(.system(size: 55))
            } else {
                CardShape.fill()
            }
            
            
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemoryGameViewModel()
        ContentView(viewModel: game)
    }
}

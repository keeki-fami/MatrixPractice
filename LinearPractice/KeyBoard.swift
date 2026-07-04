//
//  KeyBoard.swift
//  LinearPractice
//
//  Created by 櫻田聖和 on 2026/07/04.
//

import SwiftUI

struct HomeView: View {
    var generator: MatrixGenerator = .init()
    var body: some View {
        Rectangle()
            .fill(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay() {
//                Text(text)
            }
        KeyBoard(generator: generator)
    }
}

struct KeyBoard: View {
    @AppStorage("failure") var failure: Int = 0
    @AppStorage("success") var success: Int = 0
    @AppStorage("combo") var combo_store: Int = 0
    @Bindable var generator: MatrixGenerator
    enum KeyType: Hashable {
        case number(String)
        case minus
        case backspace
        case empty
        
        var title: String {
            switch self {
            case .number(let text): return text
            case .minus: return "-"
            case .backspace: return "<"
            case .empty: return ""
            }
        }
    }
    
    let grid: [[KeyType]] = [
        [.number("1"), .number("2"), .number("3"), .backspace,],
        [.number("4"), .number("5"), .number("6"), .minus],
        [.number("7"), .number("8"), .number("9"), .empty],
        [.empty, .number("0"), .empty, .empty]
    ]
    var body: some View {
        VStack {
            ForEach(0..<grid.count, id: \.self) { row in
                HStack (spacing: 8) {
                    ForEach(grid[row], id: \.self) { key in
                        keyView(key: key)
                    }
                }
            }
            Button(action: {
                // TODO: 回答処理
                let result = generator.checkAnswer()
                handleCheckAnswer(result: result)
            } ,label: {
                ZStack {
                    Rectangle()
                        .fill(.blue)
                    Text("submit")
                        .foregroundStyle(.white)
                }
            })
            .buttonStyle(NumberButtonStyle())
        }
        .padding()
        .background(Color(red: 236/255, green: 236/255, blue: 236/255))
    }
    
    @ViewBuilder
    func keyView(key: KeyType) -> some View {
        if key == .empty {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
        } else {
            Button(action: {
                handleKeyPress(key)
            } ,label: {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                    Text(key.title)
                }
            })
            .buttonStyle(NumberButtonStyle())
        }
    }
    
    func handleCheckAnswer(result: Bool) {
        generator.ansString = ""
        if result {
            generator.combo += 1
            combo_store = generator.combo
            success += 1
            generator.generate()
        } else {
            failure += 1
            combo_store = 0
            generator.combo = 0
            generator.checkAnimation.toggle()
            generator.ansString = ""
        }
    }
    
    func handleKeyPress(_ key: KeyType) {
        switch key {
        case .number(let title):
            if generator.ansString == "0" {
                generator.ansString = title
            } else {
                generator.ansString.append(title)
            }
        case .minus:
            if generator.ansString.isEmpty {
                generator.ansString.append("-")
            }
        case .backspace:
            if !generator.ansString.isEmpty {
                generator.ansString.removeLast()
            }
        default:
            break
        }
    }
}

struct NumberButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color(red: 217/255, green: 217/255, blue: 217/255))
            .foregroundColor(.black)
            .clipShape(
                RoundedRectangle(cornerRadius: 5)
            )
            .shadow(color: .black.opacity( configuration.isPressed ? 0 : 0.5 ), radius: 1, x: 0, y: 2)
    }
}

#Preview {
    HomeView()
}

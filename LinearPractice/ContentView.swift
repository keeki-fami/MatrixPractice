//
//  ContentView.swift
//  LinearPractice
//
//  Created by 櫻田聖和 on 2026/06/23.
//

import SwiftUI

extension Array {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

struct ContentView: View {
    @State var generator = MatrixGenerator()
    @State var text = ""
    @AppStorage("failure") var failure: Int = 0
    @AppStorage("success") var success: Int = 0
    @AppStorage("combo") var combo_store: Int = 0
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Group {
                    ScrollView {
                        VStack {
                            HStack {
                                MatrixGridView(matrix: generator.matrixset.matrix1)
                                operatorText
                                MatrixGridView(matrix: generator.matrixset.matrix2)
                            }
                            HStack {
                                cellText("=")
                                MatrixAnswerView(
                                    matrix: generator.matrixset.matrixAnswer,
                                    answerX: generator.matrixset.answerPointX,
                                    answerY: generator.matrixset.answerPointY
                                )
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .overlay(alignment: .bottom) {
                        HStack {
                            Text("? = ")
                            Text("\(generator.ansString.isEmpty ? "   " : generator.ansString)")
                                .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                        }
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .background(
                            .linearGradient(
                                stops: [
                                    .init(color: .clear, location: 0.0),
                                    .init(color: .white.opacity(0.7), location: 0.2),
                                    .init(color: .white, location: 1.0)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .keyframeAnimator(initialValue: 0.0, trigger: generator.checkAnimation) { content, value in
                            content.offset(x: value)
                        } keyframes: { _ in
                            KeyframeTrack {
                                MoveKeyframe(10.0)
                                LinearKeyframe(-10.0, duration: 0.1)
                                LinearKeyframe(5.0, duration: 0.1)
                                LinearKeyframe(-5.0, duration: 0.1)
                                LinearKeyframe(2.0, duration: 0.1)
                                LinearKeyframe(-2.0, duration: 0.1)
                                LinearKeyframe(1.0, duration: 0.1)
                                LinearKeyframe(-1.0, duration: 0.1)
                                LinearKeyframe(0.5, duration: 0.1)
                                LinearKeyframe(-0.5, duration: 0.1)
                            }
                            
                        }
                    }
                }
                .transition(.opacity)
                
                KeyBoard(generator: generator)
            }
            .onAppear() {
                generator.combo = combo_store
                generator.generate()
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(alignment: .bottom) {
                        Text("\(generator.combo)")
                            .font(.custom("", size: 30))
                            .contentTransition(.numericText(value: Double(generator.combo)))
                        Text("combo")
                    }
                }
                .sharedBackgroundVisibility(.hidden)
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: {
                        ProfileView()
                    }, label: {
                        Image(systemName: "info")
                    })
                }
            }
        }
    }
    var operatorText: Text {
        var op: String {
            switch generator.matrixset.calculateType {
            case .add: return "+"
            case .sub: return "-"
            default: return "*"
            }
        }
        return Text(op)
    }
}

#Preview {
    ContentView()
    //    buttonTest()
}

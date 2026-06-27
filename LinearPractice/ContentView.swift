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
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    Group {
                        VStack (alignment: .leading){
                            HStack {
                                if !generator.matrixset.matrix1.matrix.isEmpty {
                                    VStack {
                                        ForEach(generator.matrixset.matrix1.matrix, id: \.self) { matrix in
                                            HStack {
                                                ForEach(matrix, id: \.self) { num in
                                                    Text("\(num.value)")
                                                        .frame(width: 30, height: 30)
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                }
                                if generator.matrixset.calculateType == .add {
                                    Text("+")
                                } else if generator.matrixset.calculateType == .sub {
                                    Text("-")
                                } else {
                                    Text("*")
                                }
                                
                                VStack {
                                    ForEach(generator.matrixset.matrix2.matrix, id: \.self) { matrix in
                                        
                                        HStack {
                                            ForEach(matrix, id: \.self) { num in
                                                Text("\(num.value)")
                                                    .frame(width: 30, height: 30)
                                            }
                                        }
                                    }
                                    
                                }
                                .padding()
                            }
                            HStack {
                                Text("=")
                                if !generator.matrixset.matrixAnswer.matrix.isEmpty {
                                    VStack {
                                        ForEach(generator.matrixset.matrixAnswer.matrix.indices, id: \.self) { i in
                                            HStack {
                                                ForEach(0..<generator.matrixset.matrixAnswer.colDim, id: \.self) { j in
                                                    if generator.matrixset.answerPointX == i && generator.matrixset.answerPointY == j {
                                                        Text("?")
                                                            .frame(width: 30, height: 30)
                                                    } else {
                                                        if let answerrow = generator.matrixset.matrixAnswer.matrix[safe: i], let answer = answerrow[safe: j] {
                                                            Text("\(answer.value)")
                                                                .frame(width: 30, height: 30)
                                                        } else {
                                                            Text("?")
                                                                .frame(width: 30, height: 30)
                                                        }
                                                        
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }
                                    .padding()
                                }
                            }
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .transition(.opacity)
                HStack {
                    Text("? = ")
                    Text("\(generator.ansString.isEmpty ? "   " : generator.ansString)")
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                }
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
                VStack {
                    HStack {
                        Button(action: {
                            generator.ansString.append("1")
                            print("1")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("1")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            generator.ansString.append("2")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("2")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            generator.ansString.append("3")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("3")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            if !generator.ansString.isEmpty {
                                generator.ansString.removeLast()
                            }
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("<")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                    }
                    HStack {
                        Button(action: {
                            generator.ansString.append("4")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("4")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            generator.ansString.append("5")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("5")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            generator.ansString.append("6")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("6")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            if generator.ansString.isEmpty {
                                generator.ansString.append("-")
                            }
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("-")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                    }
                    HStack {
                        Button(action: {
                            generator.ansString.append("7")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("7")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            generator.ansString.append("8")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("8")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            generator.ansString.append("9")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("9")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                    }
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                        Button(action: {
                            generator.ansString.append("0")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("0")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                    }
                    Button(action: {
                        let result = generator.checkAnswer()
                        if result {
                            withAnimation {
                                generator.combo += 1
                            }
                            generator.ansString.removeAll()
                            generator.generate()
                        } else {
                            generator.ansString.removeAll()
                        }
                    } ,label: {
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                            Text("Submit")
                        }
                    })
                    .buttonStyle(NumberButtonStyle())
                }
                .frame(height: 300)
                .padding()
                .background(Color(red: 217/255, green: 217/255, blue: 217/255, opacity: 0.5))
            }
            .onAppear() {
                generator.generate()
            }
            //            .navigationTitle("Matrix Practice")
            //            .navigationBarTitleDisplayMode(.inline)
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
                    Button(action: {
                        
                    }, label: {
                        Text("9")
                    })
                }
            }
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

struct buttonTest: View {
    var body: some View {
        Button("1") {
            print("a")
        }
        .buttonStyle(NumberButtonStyle())
    }
}

#Preview {
    ContentView()
    //    buttonTest()
}

//
//  ContentView.swift
//  LinearPractice
//
//  Created by 櫻田聖和 on 2026/06/23.
//

import SwiftUI

struct ContentView: View {
    @State var generator = MatrixGenerator()
    var body: some View {
        NavigationStack {
            VStack {
//                Rectangle()
//                    .fill(.gray)
//                    .frame(maxWidth: .infinity, maxHeight: 100)
//                    .overlay(alignment: .bottom) {
//                        Text("Linear")
//                    }
//                    .overlay(alignment: .bottomTrailing) {
//                        Text("\(generator.combo)combo")
//                    }
//                    .ignoresSafeArea()
                
                HStack {
                    if !generator.matrix1.matrix.isEmpty {
                        LazyVStack {
                            ForEach(0..<generator.matrix1.rowDim, id: \.self) { i in
                                HStack {
                                    ForEach(generator.matrix1.matrix[i], id: \.self) { val in
                                        Text("\(val)")
                                            .frame(width: 20, height: 20)
                                    }
                                }
                            }
                        }
                    }
                    if generator.calculateType == .add {
                        Text("+")
                    } else if generator.calculateType == .sub {
                        Text("-")
                    } else {
                        Text("*")
                    }
                    if !generator.matrix2.matrix.isEmpty {
                        LazyVStack {
                            ForEach(0..<generator.matrix2.rowDim, id: \.self) { i in
                                HStack {
                                    ForEach(generator.matrix2.matrix[i], id: \.self) { val in
                                        Text("\(val)")
                                            .frame(width: 20, height: 20)
                                    }
                                }
                            }
                        }
                    }
                    Text("=")
                    if !generator.matrixAnswer.matrix.isEmpty {
                        LazyVStack {
                            ForEach(0..<generator.matrixAnswer.rowDim, id: \.self) { i in
                                HStack {
                                    ForEach(0..<generator.matrixAnswer.colDim, id: \.self) { j in
                                        if generator.answerPointX == i && generator.answerPointY == j {
                                            Text("?")
                                                .frame(width: 20, height: 20)
                                        } else {
                                            Text("\(generator.matrixAnswer.matrix[i][j])")
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                HStack {
                    Text("? = ")
                    Text("\(generator.ansString.isEmpty ? "   " : generator.ansString)")
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                }
                VStack {
                    HStack {
                        Button(action: {
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
                            print("2")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("2")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            print("3")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("3")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            print("<")
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
                            print("4")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("4")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            print("5")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("5")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            print("6")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("6")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            print("-")
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
                            print("7")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("7")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            print("8")
                        } ,label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                                Text("8")
                            }
                        })
                        .buttonStyle(NumberButtonStyle())
                        Button(action: {
                            print("9")
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
                            print("0")
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
                generator.generate(row1: 3, col1: 3, row2: 3, col2: 3, type: .add)
            }
//            .navigationTitle("Matrix Practice")
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(alignment: .bottom) {
                        Text("\(generator.combo)")
                            .font(.custom("", size: 30))
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

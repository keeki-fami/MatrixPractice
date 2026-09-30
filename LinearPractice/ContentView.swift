//
//  ContentView.swift
//  LinearPractice
//
//  Created by 櫻田聖和 on 2026/06/23.
//

import SwiftUI
import AppVersionMonitorSwiftUI

extension Array {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

struct ContentView: View {
    var generator = MatrixGenerator()
    @State var text = ""
    @State var updateAlert = false
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
            .alert(
                "最新版があります",
                isPresented: $updateAlert
            ) {
                Button(role: .cancel) {
                    
                } label : {
                    Text("キャンセル")
                }
                Button(role: .confirm) {
                    if let url = URL(string: "https://apps.apple.com/jp/app/%E7%84%A1%E9%99%90%E8%A1%8C%E5%88%97%E8%A8%88%E7%AE%97/id6785983550") {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            print("成功")
                        } else {
                            print("失敗1")
                        }
                    } else {
                        print("失敗2")
                    }
                } label: {
                    Text("AppStoreに移動")
                }
            } message: {
                Text("AppStoreに移動して最新版をインストールします")
            }
            .appVersionMonitor(id: 6785983550) { status in
                switch status {
                case .updateAvailable:
                    updateAlert = true
                default:
                    updateAlert = false
                }
                
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

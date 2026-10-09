//
//  ContentView.swift
//  LinearPractice
//
//  Created by keeki-fami on 2026/06/23.
//

import SwiftUI
import AppVersionMonitorSwiftUI
import GameKit

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
    @Environment(\.scenePhase) var scenePhase
    @State var gameCenterManager = GameCenterManager.shared
    @State var selectedPhase = [0, 1]
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
                        }
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
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if oldPhase == .background && newPhase == .active {
                    generator.combo = combo_store
                    generator.generate()
                } else if newPhase == .active {
                    generator.combo = combo_store
                    GKAccessPoint.shared.isActive = false
                }
                
                // active以外の状態に遷移する時、コンボを送信する
                if oldPhase == .active && newPhase != .active {
                    let comboNumber = UserDefaults.standard.integer(forKey: "combo")
                    gameCenterManager.submitScore(comboNumber, to: "com.LinearPractice.keekifami.WeeklyComboRanking")
                }
            }
            .onAppear() {
                gameCenterManager.initializeLocalPlayer()
                if gameCenterManager.isAuthenticated {
                    Task {
                        await gameCenterManager.checkDuration()
                        generator.combo = combo_store
                    }
                } else {
                    generator.combo = combo_store
                }
                generator.combo = combo_store
                    
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(alignment: .bottom) {
                        Text("\(generator.combo)")
                            .font(.custom("", size: 20))
                            .contentTransition(.numericText(value: Double(generator.combo)))
                        Text("combo")
                    }
                    .fixedSize(horizontal: true, vertical: false)

                }
                .sharedBackgroundVisibility(.hidden)
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        NavigationLink(destination: {
                            ProfileView(manager: $gameCenterManager)
                        }, label: {
                            Text("Profile")
                        })
                        
                        Button("show Ranking") {
                            gameCenterManager.showLeaderboards()
                        }
                        
                    } label: {
                        Image(systemName: "info")
                    } primaryAction: {
                        let data = UserDefaults.standard.integer(forKey: "success")
                        gameCenterManager.submitScore(data, to: "com.LinearPractice.keekifami.HighScore")
                        let comboNumber = UserDefaults.standard.integer(forKey: "combo")
                        gameCenterManager.submitScore(comboNumber, to: "com.LinearPractice.keekifami.WeeklyComboRanking")
                    }
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

//
//  ContentView.swift
//  MazinShooting
//

import SwiftUI
import RealityKit

struct ARTitleView : View {
    @EnvironmentObject var gameInfo: GameInfo
    var body: some View {
        ZStack {
            ARViewContainer(gameInfo: gameInfo)
                .edgesIgnoringSafeArea(.all)

            if gameInfo.gameState != .menu {
                Image("Aim")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(y: -25)
            }

            VStack(spacing: 200) {
                if gameInfo.gameState == .menu {
                    Text("布団ちゃんシューティング")
                        .font(.system(size: 25))
                        .fontWeight(.black)
                        .foregroundColor(.white)

                    Button {
                        self.gameInfo.gameState = .placingContent
                    } label: {
                        HStack {
                            Image("fight")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("討伐開始").bold()
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Rectangle().fill(.white))
                        .cornerRadius(10)
                    }
                }

                // ステージ表示中
                if  gameInfo.gameState == .stage1 ||
                        gameInfo.gameState == .stage2 {

                    // ライフが残っている状態
                    if gameInfo.selfLife > 0 {

                        VStack {
                            // タイトル画面へ戻るボタン
                            Button(action: {

                                self.gameInfo.gameState = .menu
                            }) {

                                Text("Menu")
                                    .padding([.trailing, .top], 15)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }

                            HPBarView()
                                .frame(maxHeight: .infinity, alignment: .bottom)
                        }
                        .padding()
                    }
                    else {
                        VStack(spacing: 200) {
                            // ゲームオーバー
                            Text("Game Over")
                                .foregroundColor(.white)
                                .font(.system(size: 60))

                            // 全回復して、続けてプレイ
                            Button(action: {
                                self.gameInfo.selfLife = 10
                            }) {
                                Text("蘇生").bold()
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Rectangle().fill(.white))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                else if  gameInfo.gameState == .endGame {
                    VStack(spacing: 200) {
                        // ゲーム終了
                        Text("Congratulation")
                            .foregroundColor(.white)
                            .font(.system(size: 60))

                        // タイトル画面へ戻る
                        Button(action: {
                            self.gameInfo.gameState = .menu
                        }) {
                            Text("Menu")
                        }
                    }
                }
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    var gameInfo: GameInfo

    func makeUIView(context: Context) -> UIView {

        return ARShootingView(frame: .zero, gameInfo: gameInfo)
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

#if DEBUG
struct ARTitleView_Previews : PreviewProvider {
    static var previews: some View {
        ARTitleView()
            .environmentObject(GameInfo())
    }
}
#endif
